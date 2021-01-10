package routers

import (
	"github.com/gin-gonic/gin"
	"github.com/wzslr321/database/postgres/funcs"
	"net/http"
)

func GetIndex(ctx *gin.Context) {
	ctx.String(http.StatusOK,"Welcome on index!" )
}


func FetchPosts(ctx *gin.Context){
	posts := funcs.GetPosts()

	ctx.JSON(http.StatusOK,gin.H{
		"title":posts.Title,
		"description" :posts.Description,
	})

}

func AddPost(ctx *gin.Context) {
	funcs.AddPost()
	ctx.JSON(http.StatusOK,gin.H{
		"status":"Cool",
	})
}
