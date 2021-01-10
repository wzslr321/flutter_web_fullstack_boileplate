package routers

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/wzslr321/database/redis"
	routers "github.com/wzslr321/routers/api"
	"time"
)

func InitRouter() *gin.Engine {

	gin.ForceConsoleColor()

	r := gin.New()

	r.Use(gin.LoggerWithFormatter(func(param gin.LogFormatterParams) string {
		return fmt.Sprintf("%s - [%s] \"%s %s %s %d %s \"%s\" %s\"\n",
			param.ClientIP,
			param.TimeStamp.Format(time.RFC1123),
			param.Method,
			param.Path,
			param.Request.Proto,
			param.StatusCode,
			param.Latency,
			param.Request.UserAgent(),
			param.ErrorMessage,
		)
	}))

	r.Use(gin.Recovery())

	posts := r.Group("/api/posts")
	{
		posts.GET("/fetch", routers.FetchPosts)
		posts.POST("/add", routers.AddPost)
	}

	test := r.Group("/api/test")
	{
		test.GET("/index", routers.GetIndex)
		test.GET("/redis", redis.ServeHome)
	}

	return r
}