package redisfuncs

import (
	"encoding/json"
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



func CreateAnnouncement() error {

	var M Announcement

	M.Title = "cool"
	M.Author = "Gary"
	M.Description = "Hello"

	data,err := json.Marshal(M); checkErr(err)
	err = Set("test", data); checkErr(err)

	return err
}


func GetAnnouncements() Announcement {

	data,err := Get("test"); checkErr(err)

	var test Announcement

	err = json.Unmarshal(data,&test)

	return test
}