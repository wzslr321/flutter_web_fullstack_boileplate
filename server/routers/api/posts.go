package routers

import (
	"github.com/gin-gonic/gin"
	"github.com/wzslr321/database/postgres/funcs"
	"log"
	"net/http"
	"strconv"
	"strings"
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

	t := ctx.Query("title")
	d := ctx.Query("description")
	a := ctx.Query("author")

	id := postgrefuncs.AddPost(t,d,a)

	ctx.JSON(http.StatusOK, gin.H{
		"id":id,
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
	t := ctx.Query("title")
	d := ctx.Query("description")
	a := ctx.Query("author")

	i := strings.ReplaceAll(id," ","")
	cnvid, err := strconv.Atoi(i)
	if err != nil {
		log.Printf("Failed to update a post: %v\n", err)
	}

	postgrefuncs.UpdatePost(cnvid, t, d, a)

	ctx.JSON(http.StatusOK, gin.H{
		"status": "updated",
		"id":cnvid,
		"title":t,
		"description": d,
		"author":a,
	})
}
