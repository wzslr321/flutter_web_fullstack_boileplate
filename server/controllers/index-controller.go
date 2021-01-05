package controllers

import (
	"github.com/gin-gonic/gin"
	"github.com/wzslr321/util"
	"net/http"
)

func GetIndex(ctx *gin.Context) {
	ctx.String(http.StatusOK,"Welcome on index!" )
}


func GetPostRoute(ctx *gin.Context){
	posts := util.GetPosts()

	ctx.Header("Access-Control-Allow-Origin", "*")
	ctx.JSON(http.StatusOK,gin.H{
		"title":posts.Title,
		"description" :posts.Description,
	})

}

func PostPostRoute(ctx *gin.Context) {
	util.AddPost()
	ctx.JSON(http.StatusOK,gin.H{
		"status":"Cool",
	})
}
