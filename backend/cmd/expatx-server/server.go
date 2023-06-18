package main

import (
	"github.com/expatx/expatx/backend/gen/go/proto/v1/auth"
	"github.com/expatx/expatx/backend/gen/go/proto/v1/user"
)

type Server struct {
	auth.UnimplementedAuthServiceServer
	user.UnimplementedUserServiceServer
}

// TODO: Implement the auth.AuthServiceServer interface.
