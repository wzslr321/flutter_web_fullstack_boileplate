package models

import (
	"github.com/lib/pq"
	"gorm.io/gorm"
)


type Post struct {
	gorm.Model
	ID          int       `gorm:"primaryKey"`
	Title       string    `json:"title"`
	Description string    `json:"description"`
	Author      Author    `gorm:"-"`
	Comments    []Comment `gorm:"-"`
}

type Author struct {
	gorm.Model
	Name string `json:"name"`
	Posts pq.Int64Array `gorm:"type:integer[]"`
}

type Comment struct {
	gorm.Model
	Body string `json:"body"`
}
