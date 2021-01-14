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

func CreateAnnouncement(key, title, description, author string) error {

	a := models.Announcement{
		Title:       title,
		Description: description,
		Author:      author,
	}

	data, err := json.Marshal(a)
	checkErr(err)

	fmt.Println(key)

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

func GetAnnouncement(key string, all bool) (models.Announcement,[]string, error) {
	var (
		a    models.Announcement
		data []byte
		keys []string
		err  error
	)

	if all == false {
		data, err = Get(key)
	} else {
		key = "announcement*"
		keys, err = GetKeys(key)
		fmt.Println(keys)
	}

	if err != nil {
		err = fmt.Errorf("announcement with this title is not existing")
	} else if all != true{
		err = json.Unmarshal(data, &a)
		checkErr(err)
	}
	return a, keys, err
}
