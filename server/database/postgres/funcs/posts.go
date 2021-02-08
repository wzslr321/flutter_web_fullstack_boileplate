package postgrefuncs

import (
	"fmt"
	"github.com/wzslr321/database/postgres"
	"github.com/wzslr321/models"
	"gorm.io/gorm"
)

var (
	post models.Post
)

func FetchPosts() *[]models.Post {
	var posts []models.Post
	tx := postgres.DB.Preload("Posts", func(db *gorm.DB) *gorm.DB {
		return db.Select("ID")
	}).Find(&posts)
	if tx.Error != nil {
		fmt.Printf("error occurred with fetch posts function %v", tx.Error)
	}
	return &posts
}

func FetchLastPost() models.Post {
	postgres.DB.First(&post)
	return post
}

func AddPost( title,description,author string) int{
	newPost := models.Post{Title:title, Description: description, Author:author}
	postgres.DB.Create(&newPost)
	return newPost.ID
}

func DeletePost(id int) {
	postgres.DB.Delete(&post, id)
}

func UpdatePost(id int, title, description,author string) {
	postgres.DB.Model(&post).Where("id=?", id).Updates(map[string]interface{}{
		"title":       title,
		"description": description,
		"author": author,
	})
}
