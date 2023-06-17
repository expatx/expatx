package auth

import (
	"context"
	"github.com/jinzhu/gorm"
	"github.com/pkg/errors"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"strings"
	"time"

	auth "github.com/expatx/expatx/backend/gen/go/proto/auth/v1"
)

// Auth represents the authentication service.
type Auth struct {
	db *gorm.DB
}

// NewAuth creates a new Auth service.
func NewAuth(db *gorm.DB) *Auth {
	return &Auth{db: db}
}

// Login logs in a user.
//
// Args:
//
//	ctx: The context of the request.
//	req: The login request.
//
// Returns:
//
//	A LoginResponse containing the JWT for the logged in user.
//
// Raises:
//   - InvalidArgumentError: If the username or password is empty.
//   - NotFoundError: If the user is not found.
//   - InvalidArgumentError: If the password is incorrect.
func (a *Auth) Login(ctx context.Context, req *auth.LoginRequest) (*auth.LoginResponse, error) {
	// Validate the request.
	if len(req.Username) == 0 {
		return nil, status.Errorf(codes.InvalidArgument, "username is required")
	}
	if len(req.Password) == 0 {
		return nil, status.Errorf(codes.InvalidArgument, "password is required")
	}

	user := User{}
	if err := a.db.Where("username = ?", req.Username).First(&user).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, status.Errorf(codes.NotFound, "user not found")
		} else {
			return nil, err
		}
	}

	if !strings.Equal(user.Password, req.Password) {
		return nil, status.Errorf(codes.InvalidArgument, "invalid password")
	}

	jwt, err := GenerateJWT(user.ID)
	if err != nil {
		return nil, err
	}

	return &auth.LoginResponse{Jwt: jwt}, nil
}

// GenerateJWT generates a JWT for a user.
//
// Args:
//
//	id: The ID of the user.
//
// Returns:
//
//	A string containing the JWT.
func GenerateJWT(id string) (string, error) {
	claims := jwt.NewClaims()
	claims.SetID(id)
	claims.SetIssuer("expatx")
	claims.SetAudience("expatx-client")
	claims.SetExpiration(time.Now().Add(time.Hour))

	signer := jwt.NewSigner(jwt.RS256, []byte("secret"))
	jwt, err := signer.Sign(claims)
	if err != nil {
		return "", err
	}

	return jwt, nil
}

// User represents a user in the database.
type User struct {
	ID       string `gorm:"primary_key"`
	Username string
	Email    string
	Password string
}

// LoginRequest represents a login request.
type LoginRequest struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

// LoginResponse represents a login response.
type LoginResponse struct {
	Jwt string `json:"jwt"`
}
