package routers

import (
	"github.com/gin-gonic/gin"
	redisfuncs "github.com/wzslr321/database/redis/funcs"
	"log"
	"net/http"
)

func PostAnnouncement(ctx *gin.Context)  {
	err := redisfuncs.CreateAnnouncement()
	if err != nil {
		log.Printf("Error while posting an announcement: %v\n", err)
	}

	ctx.JSON(http.StatusOK,gin.H{
		"status":"posted",
	})
}

func FetchAnnouncements(ctx *gin.Context) {
	ann := redisfuncs.GetAnnouncements()

	if ann.Title != "" {
		ctx.JSON(http.StatusOK, gin.H{
			"title":ann.Title,
			"description": ann.Description,
			"author": ann.Author,
		})
	} else {
		ctx.JSON(http.StatusOK, gin.H{
			"status":"There is no announcement with this id.",
		})
	}
}