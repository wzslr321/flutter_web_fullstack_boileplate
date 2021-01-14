package redisfuncs

import (
	"encoding/json"
	"fmt"
	"github.com/wzslr321/models"
	"log"
)



func checkErr(err error) {
	if err != nil {
		log.Fatalf("Error occured with redis announcements functions: %v", err)
	}
}

func CreateAnnouncement(key, description, author string) error {

	a := models.Announcement{
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

func GetAnnouncement(key string) (models.Announcement,error) {
	var a models.Announcement

	data, err := Get(key)
	if err != nil {
		err = fmt.Errorf("announcement with this title is not existing")
	} else {
		err = json.Unmarshal(data, &a)
		checkErr(err)
	}
	return a,err
}
