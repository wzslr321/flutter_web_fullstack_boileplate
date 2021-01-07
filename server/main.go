package main

import (
	"github.com/gin-gonic/gin"
	"github.com/wzslr321/controllers"
	"github.com/wzslr321/util"
)


func main() {
	util.InitDB()
	util.InitializeRedis()
	router := gin.Default()

	router.GET("/api/", controllers.GetIndex)
	router.GET("/api/posts", controllers.GetPostRoute)
	router.POST("/api/add/post", controllers.AddPostRoute)
	//router.GET("/posts/all", controllers.MainPostController)
	//router.POST("/post", controllers.MainPostController)
	 router.GET("/api/redis", util.ServeHome)

	_ = router.Run(":8000")
}
