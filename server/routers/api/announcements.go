package routers

import (
	"fmt"
	"github.com/gin-gonic/gin"
	redisfuncs "github.com/wzslr321/database/redis/funcs"
	"github.com/wzslr321/models"
	"net/http"
)

func PostAnnouncement(ctx *gin.Context) {
	id := ctx.Param("id")
	key := fmt.Sprintf("announcement%s",id)
	title := "test"
	dsc := ctx.PostForm("description")
	a := ctx.PostForm("author")

	err := redisfuncs.CreateAnnouncement(key, title,dsc, a)
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
	var (
		err error
		a models.Announcement
		keys []string
	)

	key := ctx.Param("key")
	all := ctx.Query("all")


	if all != "true" {
		a,_, err = redisfuncs.GetAnnouncement(key,false)
	} else {
		a,keys,err = redisfuncs.GetAnnouncement(key,true)
	}

	if err != nil {
		noMatch(ctx)
	} else if all != "true"{
		ctx.JSON(http.StatusOK, gin.H{
			"title":       a.Title,
			"description": a.Description,
			"author":      a.Author,
		})
	} else {
		var anns []models.Announcement

		for _,k := range keys{
			fmt.Println(k)
			a,_,err = redisfuncs.GetAnnouncement(k,false)
			fmt.Println(a)
			anns = append(anns, a)
		}

		ctx.JSON(http.StatusOK, gin.H{
			"announcments":anns,
		})
	}
}

func noMatch(ctx *gin.Context) {
	ctx.JSON(http.StatusOK, gin.H{
		"status": "There is no announcement with this title",
	})
}
