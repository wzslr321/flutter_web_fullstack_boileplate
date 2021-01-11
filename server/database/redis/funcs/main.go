package redisfuncs

import (
	"fmt"
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

	var data []byte
	data,err := redis.Bytes(conn.Do("GET", key)); checkError(err)

	fmt.Println(data)

	return data, err
}
type P struct {
	X, Y, Z int
	Name    string
}

type Q struct {
	X, Y *int32
	Name string
}

func Set(key string, value []byte) error {
	conn := redisdb.Pool.Get()
	defer conn.Close()

	var err error

	_, err = conn.Do("SET", key, value); checkErr(err)

	return err
}

func Exists(key string) (bool, error) {

	conn := redisdb.Pool.Get()
	defer conn.Close()

	var err error
	var isOK bool

	isOK, err = redis.Bool(conn.Do("EXISTS", key)); checkError(err)

	return isOK, err
}

