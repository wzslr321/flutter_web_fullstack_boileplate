package routers

import (
	"github.com/gin-gonic/gin"
	"github.com/wzslr321/database/postgres/funcs"
	"net/http"
)

func GetIndex(ctx *gin.Context) {
	ctx.String(http.StatusOK, "Welcome on index!")
}

func FetchPosts(ctx *gin.Context) {
	posts := postgrefuncs.FetchPosts()

	ctx.JSON(http.StatusOK, gin.H{
		"title":       posts.Title,
		"description": posts.Description,
	})

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
