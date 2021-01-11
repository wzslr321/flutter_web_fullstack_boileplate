package redisfuncs

import (
	"bytes"
	"encoding/gob"
	"fmt"
	"log"
)

type Announcement struct {
	Title string 		`redis:"title" json:"title"`
	Description string  `redis:"author" json:"description"`
	Author string 		`redis:"author" json:"author"`
}

func checkErr(err error) {
	if err != nil {
		log.Fatalf("Error occured with redis announcements functions: %v",err)
	}
}

var (
	network bytes.Buffer
	enc = gob.NewEncoder(&network)
	dec = gob.NewDecoder(&network)
)

func CreateAnnouncement() error {
	var err error

	var M Announcement

	M.Title = "cool"
	M.Author = "Gary"
	M.Description = "Hello"

	err = enc.Encode(M)
	err = Set("cool",network.Bytes()); checkErr(err)

	return err
}


func GetAnnouncements() Announcement {
	var ann Announcement

	data,err := Get("cool")

	fmt.Println(data)
	fmt.Println("Data up")
	err = dec.Decode(&data)
	if err != nil {
		log.Fatalf("cdfsdfp, %v", err)
	}

	fmt.Println(data)

	return ann
}
