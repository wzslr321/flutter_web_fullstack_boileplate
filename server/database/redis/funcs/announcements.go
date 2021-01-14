package redisfuncs

import (
	"encoding/json"
	"fmt"
	"log"
)

type Announcement struct {
	Title       string `redis:"title" form:"title" json:"title" binding:"required"`
	Description string `redis:"description" form:"description" json:"description" binding:"required"`
	Author      string `redis:"author" form:"author" json:"author" binding:"required"`
}

type Author struct {
	Name    string `redis:"author_name" form:"author_name" json:"author_name" binding:"required"`
	Surname string `redis:"author_surname" form:"author_surname" json:"author_surname" binding:"required"`
}

func checkErr(err error) {
	if err != nil {
		log.Fatalf("Error occured with redis announcements functions: %v", err)
	}
}

func CreateAnnouncement(key, description, author string) error {

	a := Announcement{
		Title:       key,
		Description: description,
		Author:      author,
	}

	data, err := json.Marshal(a)
	checkErr(err)

	var yes bool
	yes, err = Exists(key)
	if yes {
		err = fmt.Errorf("post with this title already exists")
	} else {
		err = Set(key, data)
		checkErr(err)
	}

	return err
}

func GetAnnouncement(key string) (Announcement,error) {
	var a Announcement

	data, err := Get(key)
	if err != nil {
		err = fmt.Errorf("announcement with this title is not existing")
	} else {
		err = json.Unmarshal(data, &a)
		checkErr(err)
	}
	return a,err
}
