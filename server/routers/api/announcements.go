package routers

import (
	"github.com/gin-gonic/gin"
	redisfuncs "github.com/wzslr321/database/redis/funcs"
	"log"
	"net/http"
)

func checkErr(err error) {
	if err != nil {
		log.Fatalf("Error occured with announcements  api functions: %v",err)
	}
}

func PostAnnouncement(ctx *gin.Context)  {
	err := redisfuncs.CreateAnnouncement(); checkErr(err)

	ctx.JSON(http.StatusOK,gin.H{
		"status":"posted",
	})
}

func FetchAnnouncements(ctx *gin.Context) {
	ann := redisfuncs.GetAnnouncements()

	ctx.JSON(http.StatusOK, gin.H{
		"title":ann.Title,
		"description": ann.Description,
		"author": ann.Author,
	})
}