package routers

import (
	"fmt"
	"github.com/gin-gonic/gin"
	redisfuncs "github.com/wzslr321/database/redis/funcs"
	"github.com/wzslr321/models"
	"log"
	"net/http"
)

func PostAnnouncement(ctx *gin.Context) {

	var (
		title = ctx.Query("title")
		a     = ctx.Query("author")
		key   = fmt.Sprintf("announcement%s", title)
	)

	err := redisfuncs.CreateAnnouncement(key, title, a)
	if err != nil {
		ctx.JSON(http.StatusOK, gin.H{
			"status": "Announcement with this title already exists!",
		})
	} else {
		ctx.JSON(http.StatusOK, gin.H{
			"title":  title,
			"author": a,
			"key":    key,
		})
	}
}

func FetchAnnouncements(ctx *gin.Context) {
	var (
		err  error
		a    models.Announcement
		keys []string
	)

	key := ctx.Param("key")
	all := ctx.Query("all")

	if all != "true" {
		a, _, err = redisfuncs.GetAnnouncement(key, false)
	} else {
		a, keys, err = redisfuncs.GetAnnouncement(key, true)
	}

	if err != nil {
		noMatch(ctx)
	} else if all != "true" {
		ctx.JSON(http.StatusOK, gin.H{
			"key":    key,
			"title":  a.Title,
			"author": a.Author,
		})
	} else {
		var anns = []models.Announcement{}

		for _, k := range keys {
			a, _, err = redisfuncs.GetAnnouncement(k, false)
			anns = append(anns, a)
		}

		ctx.JSON(http.StatusOK, anns)

	}
}

func DeleteAnnouncement(ctx *gin.Context) {
	key := ctx.Param("key")

	err := redisfuncs.Delete(key)
	if err != nil {
		log.Printf("Failed to delete announcement: %v", err)
	}
}

func noMatch(ctx *gin.Context) {
	ctx.JSON(http.StatusOK, gin.H{
		"status": "There is no announcement with this title",
	})
}
