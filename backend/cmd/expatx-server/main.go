package main

import (
	"fmt"
	"github.com/expatx/expatx/backend/gen/go/proto/v1/auth"
	"github.com/expatx/expatx/backend/gen/go/proto/v1/user"
	"log"
	"net"

	"google.golang.org/grpc"
)

func main() {
	lis, err := net.Listen("tcp", ":50051")
	if err != nil {
		log.Fatalf("Failed to listen on port 50051: %v", err)
	}

	s := grpc.NewServer()

	server := &Server{}
	auth.RegisterAuthServiceServer(s, server)
	user.RegisterUserServiceServer(s, server)

	fmt.Println("Server is running on port 50051...")
	if err := s.Serve(lis); err != nil {
		log.Fatalf("Failed to serve: %v", err)
	}
}
