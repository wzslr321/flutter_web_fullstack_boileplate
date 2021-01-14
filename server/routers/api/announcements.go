package routers

import (
	"github.com/gin-gonic/gin"
	redisfuncs "github.com/wzslr321/database/redis/funcs"
	"net/http"
)

func PostAnnouncement(ctx *gin.Context) {

	key := ctx.PostForm("title")
	dsc := ctx.PostForm("description")
	a := ctx.PostForm("author")

	err := redisfuncs.CreateAnnouncement(key, dsc, a)
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

func FetchAnnouncement(ctx *gin.Context) {

	key := ctx.Param("key")
	ann, err := redisfuncs.GetAnnouncement(key)

	if err != nil {
		noMatch(ctx)
	} else {
		ctx.JSON(http.StatusOK, gin.H{
			"title":       ann.Title,
			"description": ann.Description,
			"author":      ann.Author,
		})
	}
}

func noMatch(ctx *gin.Context) {
	ctx.JSON(http.StatusOK, gin.H{
		"status": "There is no announcement with this title",
	})
}
