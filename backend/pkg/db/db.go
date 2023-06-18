package db

import (
	"context"
	"time"

	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type Document interface{}

// DB represents a MongoDB instance
type DB struct {
	Client *mongo.Client
}

// NewDB creates a new DB instance
func NewDB(uri string) (*DB, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	client, err := mongo.Connect(ctx, options.Client().ApplyURI(uri))
	if err != nil {
		return nil, err
	}
	return &DB{Client: client}, nil
}

// GetCollection gets a collection from the database
func (db *DB) GetCollection(database string, collection string) *mongo.Collection {
	return db.Client.Database(database).Collection(collection)
}

// InsertDocument inserts a new document into the collection
func (db *DB) InsertDocument(database string, collection string, doc any) (*mongo.InsertOneResult, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	return db.GetCollection(database, collection).InsertOne(ctx, doc)
}
