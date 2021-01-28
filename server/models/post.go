package models

import (
	"gorm.io/gorm"
)

type Post struct {
	gorm.Model
	ID          int    `gorm:"primaryKey"`
	Title       string `json:"title"`
	Description string `json:"description"`
	Author      string `json:"author"`
}
