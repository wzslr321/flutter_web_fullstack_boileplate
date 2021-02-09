package routers

import (
	"fmt"
	"github.com/gin-gonic/gin"
	routers "github.com/wzslr321/routers/api"
	"time"
)

func InitRouter() *gin.Engine {

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

	posts := r.Group("/api/post")
	{
		posts.POST("/add", routers.AddPost)
		posts.GET("/", routers.FetchPosts)
		posts.GET("/last", routers.FetchLastPost)
		posts.DELETE("/:id", routers.DeletePost)
		posts.PATCH("/:id", routers.UpdatePost)
	}

	announcements := r.Group("/api/announcement")
	{
		announcements.POST("/add", routers.PostAnnouncement)
		announcements.GET("/:key", routers.FetchAnnouncements)
		announcements.PATCH("/:key")
		announcements.DELETE("/:key", routers.DeleteAnnouncement)
	}

	return r
}
