package util

import "github.com/wzslr321/models"

func GetPosts() models.Post {
	var post models.Post
	Db.First(&post)
	return post
}

func AddPost(){
	firstPost := models.Post{Title: "Hello", Description: "I am first post"}
	 Db.Create(&firstPost)
}