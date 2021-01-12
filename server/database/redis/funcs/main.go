package redisfuncs

import (
	"github.com/gomodule/redigo/redis"
	"github.com/wzslr321/database/redis"
	"log"
)

func checkError(err error) {
	if err != nil {
		log.Fatalf("Error occured with redis functions: %v",err)
	}
}

func Get(key string) ([]byte, error) {
	conn := redisdb.Pool.Get()
	defer conn.Close()

	data,err := redis.Bytes(conn.Do("GET", key)); checkError(err)

	return data, err
}

func Set(key string, value []byte) error {
	conn := redisdb.Pool.Get()
	defer conn.Close()

	_, err := conn.Do("SET", key, value); checkErr(err)

	return err
}
