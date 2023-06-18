package auth

import (
	"context"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"os"
	"strings"
	"time"

	"github.com/expatx/expatx/backend/gen/go/proto/v1/auth"
	"github.com/expatx/expatx/backend/gen/go/proto/v1/user"
	jwt "github.com/golang-jwt/jwt"
)

// Database represents the database operations required by the authentication service.
type Database interface {
	FindUserByUsername(ctx context.Context, username string) (*user.User, error)
}

// Auth represents the authentication service.
type Auth struct {
	db Database
}

// NewAuth creates a new Auth service.
func NewAuth(db Database) *Auth {
	return &Auth{db: db}
}

// Login logs in a user.
func (a *Auth) Login(ctx context.Context, req *auth.LoginRequest) (*auth.LoginResponse, error) {
	// Validate the request.
	if len(req.Username) == 0 {
		return nil, status.Errorf(codes.InvalidArgument, "username is required")
	}
	if len(req.Password) == 0 {
		return nil, status.Errorf(codes.InvalidArgument, "password is required")
	}

	user, err := a.db.FindUserByUsername(ctx, req.Username)
	if err != nil {
		if status.Code(err) == codes.NotFound {
			return nil, status.Errorf(codes.NotFound, "user not found")
		} else {
			return nil, err
		}
	}

	if !strings.EqualFold(user.Password, req.Password) {
		return nil, status.Errorf(codes.InvalidArgument, "invalid password")
	}

	jwtToken, err := generateJWT(user.Id)
	if err != nil {
		return nil, err
	}

	return &auth.LoginResponse{Token: jwtToken}, nil
}

// generateJWT generates a JWT for a user.
func generateJWT(userID string) (string, error) {
	claims := jwt.MapClaims{
		"sub": userID,
		"exp": time.Now().Add(time.Hour).Unix(),
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	tokenString, err := token.SignedString([]byte(os.Getenv("JWT_SECRET")))
	if err != nil {
		return "", err
	}

	return tokenString, nil
}
