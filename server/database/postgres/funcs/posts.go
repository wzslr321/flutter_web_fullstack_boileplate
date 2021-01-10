package postgrefuncs

import (
	"github.com/wzslr321/database/postgres"
	"github.com/wzslr321/models"
)

var (
	post models.Post
)

func FetchPosts() models.Post {
	postgres.Db.First(&post)
	return post
}

func FetchLastPost() models.Post {
	postgres.Db.First(&post)
	return post
}

func AddPost(){
	firstPost := models.Post{Title: "Hello", Description: "I am first post"}
	 postgres.Db.Create(&firstPost)
}