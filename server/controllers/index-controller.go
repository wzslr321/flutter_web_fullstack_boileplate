package controllers

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"github.com/wzslr321/models"
	"github.com/wzslr321/util"
)

func GetIndex(ctx *gin.Context) {
	ctx.String(http.StatusOK,"Welcome on index!" )
}


func GetPostRoute(ctx *gin.Context){

	post := models.Post{}

	util.Db.First(&post,"title = ?", "first test")

	ctx.Header("Access-Control-Allow-Origin", "*")
	ctx.JSON(http.StatusOK,gin.H{
		"title":post.Title,
		"description" :post.Description,
	})

}