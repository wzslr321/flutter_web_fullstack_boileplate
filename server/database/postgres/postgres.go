package postgres

import (
	"database/sql"
	"github.com/joho/godotenv"
	"github.com/wzslr321/models"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
	"gorm.io/gorm/schema"
	"log"
	"os"
	"time"
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

func checkError(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func InitDB() {
	err := godotenv.Load(".env"); checkError(err)

	var (
		DBName = os.Getenv("POSTGRES_DB")
		DBPswd = os.Getenv("POSTGRES_PASSWORD")
	)

	var newLogger = logger.New(
		log.New(os.Stdout,"\r\n", log.LstdFlags),
		logger.Config{
			SlowThreshold: time.Second,
			LogLevel: logger.Silent,
			Colorful: true,
		},
	)

	dsn := "host=postgresql user=postgres password=" + DBPswd +  " dbname=" + DBName + " port=5432 sslmode=disable TimeZone=Europe/Warsaw"

	Db, err = gorm.Open(postgres.New(postgres.Config{
		DSN: dsn,
	}), &gorm.Config{
		Logger: newLogger,
	}); checkError(err)

	_ = Db.AutoMigrate(
		&models.Post{},
		&models.Author{},
		&models.Comment{},
	)

}

