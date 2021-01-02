package main

import (
	"github.com/gin-gonic/gin"
	"github.com/wzslr321/controllers"
	"github.com/wzslr321/util"
)


func main() {

	util.InitializeRedis()
	router := gin.Default()

	router.GET("/", controllers.GetIndex)
	router.GET("/posts", controllers.GetPostRoute)
	router.GET("/posts/all", controllers.MainPostController)
	router.POST("/post", controllers.MainPostController)
	router.GET("/redis", util.ServeHome)


	_ = router.Run(":8000")
}
