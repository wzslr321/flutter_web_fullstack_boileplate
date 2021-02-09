package redisfuncs

import (
	"fmt"
	"github.com/gomodule/redigo/redis"
	"github.com/wzslr321/database/redis"
	"log"
)

func checkError(err error) {
	if err != nil {
		log.Fatalf("Error occured with redis functions: %v", err)
	}
}

func Get(key string) ([]byte, error) {
	conn := redisdb.Pool.Get()
	defer conn.Close()

	exists, err := Exists(key)

	var data []byte

	if exists {
		data, err = redis.Bytes(conn.Do("GET", key))
		checkError(err)
	} else {
		err = fmt.Errorf("key does not exist")
	}

	return data, err
}

func Set(key string, value []byte) error {
	conn := redisdb.Pool.Get()
	defer conn.Close()

	_, err := conn.Do("SET", key, value)
	checkErr(err)

	return err
}
func Exists(key string) (bool, error) {

	conn := redisdb.Pool.Get()
	defer conn.Close()

	var err error
	var isOK bool

	isOK, err = redis.Bool(conn.Do("EXISTS", key))
	checkError(err)

	return isOK, err
}

func Delete(key string) error {
	conn := redisdb.Pool.Get()
	defer conn.Close()

	_, err := conn.Do("DEL", key)
	fmt.Println(key)
	return err
}

func GetKeys(pattern string) ([]string, error) {
	conn := redisdb.Pool.Get()
	defer conn.Close()

	var (
		i    int
		keys []string
	)

	for {
		arr, err := redis.Values(conn.Do("SCAN", i, "MATCH", pattern))
		if err != nil {
			log.Printf("failed to retrieve keys: %v", pattern)
		}
		i, _ = redis.Int(arr[0], nil)
		k, _ := redis.Strings(arr[1], nil)
		keys = append(keys, k...)

		if i == 0 {
			break
		}
	}

	return keys, nil
}
