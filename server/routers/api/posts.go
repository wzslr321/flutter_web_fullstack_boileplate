package routers

import (
	"github.com/gin-gonic/gin"
	"github.com/wzslr321/database/postgres/funcs"
	"log"
	"net/http"
	"strconv"
)

func FetchPosts(ctx *gin.Context) {

	posts := postgrefuncs.FetchPosts()

	ctx.JSON(http.StatusOK,posts)
}

func FetchLastPost(ctx *gin.Context) {
	post := postgrefuncs.FetchLastPost()

	ctx.JSON(http.StatusOK, gin.H{
		"title":       post.Title,
		"description": post.Description,
	})
}

func AddPost(ctx *gin.Context) {
	postgrefuncs.AddPost()
	ctx.JSON(http.StatusOK, gin.H{
		"status": "Cool",
	})
}

func DeletePost(ctx *gin.Context) {
	id := ctx.Param("id")
	cnvid, err := strconv.Atoi(id)
	if err != nil {
		log.Printf("Failed to delete a post: %v\n", err)
	}
	postgrefuncs.DeletePost(cnvid)
	ctx.JSON(http.StatusOK, gin.H{
		"status": "deleted",
	})
}

func UpdatePost(ctx *gin.Context) {
	id := ctx.Param("id")
	t := ctx.Param("title")
	d := ctx.Param("description")
	cnvid, err := strconv.Atoi(id)
	if err != nil {
		log.Printf("Failed to update a post: %v\n", err)
	}

	postgrefuncs.UpdatePost(cnvid, t, d)

	ctx.JSON(http.StatusOK, gin.H{
		"status": "updated",
	})
}
