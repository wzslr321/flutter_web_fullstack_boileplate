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

func CreateAnnouncement(title, description, author string) error {

	a := Announcement{
		Title:       title,
		Description: description,
		Author:      author,
	}

	data, err := json.Marshal(a)
	checkErr(err)

	var yes bool
	yes, err = Exists(title)
	if yes {
		err = fmt.Errorf("post with this title already exists")
	} else {
		err = Set(title, data)
		checkErr(err)
	}

	return err
}

type Response struct {
	Announcement
	A Announcement
	Err error
}

func GetAnnouncements(key string) Response {
	var a Announcement
	var r Response

	data, err := Get(key)
	if err != nil {
		r.A= a
		err = json.Unmarshal(data, &a)
		checkErr(err)
	} else {
		r.Err = fmt.Errorf("announcement with this title is not existing")
	}
	return r
}
