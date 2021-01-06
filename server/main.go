package main

import (
	"github.com/gin-gonic/gin"
	"github.com/wzslr321/controllers"
	"github.com/wzslr321/util"
)


func main() {
	util.InitDB()
	router := gin.Default()

	router.GET("/", controllers.GetIndex)
	router.GET("/posts", controllers.GetPostRoute)
	router.POST("/posts", controllers.PostPostRoute)
	router.GET("/posts/all", controllers.MainPostController)
	router.POST("/post", controllers.MainPostController)

	_ = router.Run(":8000")
}
