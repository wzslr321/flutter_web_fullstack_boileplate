package util

import (
	"database/sql"
	"fmt"
	"github.com/wzslr321/models"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/schema"
	"log"
)

var Db *gorm.DB

type Migrator interface {
	AutoMigrate(dst ...interface{}) error

	CurrentDatabase() string

	CreateTable(dst ...interface{}) error
	DropTable(dst ...interface{}) error
	HasTable(dst interface{}) bool
	RenameTable(oldName,newName interface{}) error

	AddColumn(dst interface{}, field string) error
	DropColumn(dst interface{}, field string) error
	AlterColumn(dst interface{}, field string) error
	HasColumn(dst interface{}, field string) bool
	RenameColumn(dst interface{}, oldName, field string) error
	MigrateColumn(dst interface{}, field *schema.Field, columnType *sql.ColumnType) error
	ColumnTypes(dst interface{}) ([]*sql.ColumnType, error)

	CreateConstraint(dst interface{}, name string) error
	DropConstraint(dst interface{}, name string) error
	HasConstraint(dst interface{}, name string) bool

	CreateIndex(dst interface{}, name string) error
	DropIndex(dst interface{}, name string) error
	HasIndex(dst interface{}, name string) bool
	RenameIndex(dst interface{}, oldName, newName string) error
}

func InitDB() {
	var err error

	dsn := "host=postgresql user=postgres password=mypswd dbname=forumwebsite port=5432 sslmode=disable TimeZone=Europe/Warsaw"
	fmt.Println("cOOL")
	Db, err = gorm.Open(postgres.Open(dsn), new(gorm.Config))
	if err != nil {
		log.Panic(err)
	}

	 Db.AutoMigrate(
		&models.Post{},
		&models.Author{},
		&models.Comment{},
	)

}

