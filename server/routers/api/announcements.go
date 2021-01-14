package routers

import (
	"github.com/gin-gonic/gin"
	redisfuncs "github.com/wzslr321/database/redis/funcs"
	"net/http"
)

func PostAnnouncement(ctx *gin.Context) {
	err := redisfuncs.CreateAnnouncement("es", "es2", "es3")
	if err != nil {
		ctx.JSON(http.StatusOK, gin.H{
			"status": "Announcement with this title already exists!",
		})
	} else {
		ctx.JSON(http.StatusOK, gin.H{
			"status": "posted",
		})
	}
}

func FetchAnnouncements(ctx *gin.Context) {

	resp := redisfuncs.GetAnnouncements("esasaaa")

	if resp.Err != nil {
		noMatch(ctx)
	} else {
		ctx.JSON(http.StatusOK, gin.H{
			"title":       resp.Title,
			"description": resp.Description,
			"author":      resp.Author,
		})
	}
}

func noMatch(ctx *gin.Context) {
	ctx.JSON(http.StatusOK, gin.H{
		"status": "There is no announcement with this id.",
	})
}
