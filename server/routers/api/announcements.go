package routers

import (
	"github.com/gin-gonic/gin"
	"github.com/gomodule/redigo/redis"
	redisdb "github.com/wzslr321/database/redis"
	"log"
	"net/http"
)



func FetchAnnouncements(ctx *gin.Context)  {

	conn := redisdb.RedisPool.Get()
	defer conn.Close()


	var p1,p2 struct{
		Title string `redis:"title" json:"title"`
		Author string `redis:"author" json:"author"`
		Body string `redis:"body" json:"body"`
	}

	p1.Title = "Example"
	p1.Author = "Gary"
	p1.Body = "Hello"

	if _, err := conn.Do("HMSET", redis.Args{}.Add("id1").AddFlat(&p1)...); err != nil {
		log.Fatalf("Error occured with redis HMSEET, %v", err)
	}

	m := map[string]string{
		"title":"Example2",
		"author":"Steve",
		"body":"Map",
	}

	if _, err := conn.Do("HMSET", redis.Args{}.Add("id2").AddFlat(m)...); err != nil {
		log.Fatalf("Error occured with redis HMSEET, %v", err)
	}

	for _,id := range[]string{"id1","id2"}{
		v,err := redis.Values(conn.Do("HGETALL", id))
		if err != nil {
			log.Fatalf("Error occured with HGETALL %v", err)
		}
		if err := redis.ScanStruct(v,&p2); err != nil {
			log.Fatalf("Error occured while scanning struct p")
		}
	}

	ctx.JSON(http.StatusOK, gin.H{
		"title": p1.Title,
		"description": p1.Body,
		"authorr":p1.Author,
	})

}
