
package util
/*

import (
	"context"
	"flag"
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/gomodule/redigo/redis"
	"log"
	"net/http"
	"time"
)

func newPool() *redis.Pool {
	return &redis.Pool{
		MaxIdle:3,
		IdleTimeout:240 * time.Second,
		DialContext: func(context.Context) (redis.Conn, error) {
			return redis.Dial("tcp",":6379")
		},
	}
}

var (
	pool *redis.Pool
)



func InitializeRedis() {
	flag.Parse()
	pool = newPool()
}

func ServeHome(ctx *gin.Context){

	conn := pool.Get()
	defer conn.Close()
	fmt.Println("xd!")
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
		return
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
			return
		}
		if err := redis.ScanStruct(v,&p2); err != nil {
			log.Fatalf("Error occured while scanning struct p")
			return
		}
		fmt.Printf("%v\n",p2)
	}
	ctx.JSON(http.StatusOK, gin.H{
		"message":p2,
		"message2":p1,
	})
}

*/