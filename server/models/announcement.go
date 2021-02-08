package models

type Announcement struct {
	Title       string `redis:"title" form:"title" json:"title" binding:"required"`
	Author      string `redis:"author" form:"author" json:"author" binding:"required"`
}
