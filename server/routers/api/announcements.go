package routers

import (
	"github.com/gin-gonic/gin"
	redisfuncs "github.com/wzslr321/database/redis/funcs"
	"net/http"
)

func PostAnnouncement(ctx *gin.Context)  {

	ann := redisfuncs.CreateAnnouncement()

	ctx.JSON(http.StatusOK,gin.H{
		"title":ann.Title,
		"description":ann.Description,
		"author": ann.Author,
		"date": ann.Date,
	})

}