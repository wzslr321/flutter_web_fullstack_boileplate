package postgrefuncs

import (
	"github.com/wzslr321/database/postgres"
	"github.com/wzslr321/models"
)

var (
	post models.Post
)

func FetchPosts() models.Post {
	postgres.DB.First(&post)
	return post
}

func FetchLastPost() models.Post {
	postgres.DB.First(&post)
	return post
}

func AddPost() {
	firstPost := models.Post{Title: "Hello", Description: "I am first post"}
	postgres.DB.Create(&firstPost)
}

func DeletePost(id int) {
	postgres.DB.Delete(&post, id)
}

func UpdatePost(id int, title, description string) {
	postgres.DB.Model(&post).Where("id=?", id).Updates(map[string]string{
		"title":       title,
		"description": description,
	})
}
