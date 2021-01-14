package routers

import (
	"github.com/gin-gonic/gin"
	redisfuncs "github.com/wzslr321/database/redis/funcs"
	"net/http"
)

func PostAnnouncement(ctx *gin.Context)  {
	err := redisfuncs.CreateAnnouncement("es","es2","es3")
	if err != nil {
		ctx.JSON(http.StatusOK, gin.H{
			"status":"Announcement with this title already exists!",
		})
	} else {
		ctx.JSON(http.StatusOK,gin.H{
			"status":"posted",
		})
	}
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
		noMatch(ctx)
	}
}

func noMatch(ctx *gin.Context) {
	ctx.JSON(http.StatusOK, gin.H{
		"status":"There is no announcement with this id.",
	})
}