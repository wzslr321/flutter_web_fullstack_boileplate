package funcs

import (
	"github.com/wzslr321/database/postgres"
	"github.com/wzslr321/models"
)

func GetPosts() models.Post {
	var post models.Post
	postgres.Db.First(&post)
	return post
}

func AddPost(){
	firstPost := models.Post{Title: "Hello", Description: "I am first post"}
	 postgres.Db.Create(&firstPost)
}