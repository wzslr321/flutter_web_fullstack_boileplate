package models

type Announcement struct {
	Id          string `redis:"id" form:"id" json:"id" binding:"required"`
	Title       string `redis:"title" form:"title" json:"title" binding:"required"`
	Description string `redis:"description" form:"description" json:"description" binding:"required"`
	Author      string `redis:"author" form:"author" json:"author" binding:"required"`
}
