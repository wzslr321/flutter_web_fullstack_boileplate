package postgres

import (
	"fmt"
	"github.com/wzslr321/models"
	"github.com/wzslr321/settings"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
	"log"
	"os"
	"time"
)

var DB *gorm.DB

func checkError(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func InitPostgre() {
	var err error

	var newLogger = logger.New(
		log.New(os.Stdout, "\r\n", log.LstdFlags),
		logger.Config{
			SlowThreshold: time.Second,
			LogLevel:      logger.Silent,
			Colorful:      true,
		},
	)

	var s = settings.PostgresSettings

	dsn := fmt.Sprintf(
		"host=%s user=%s password=%s dbname=%s port=%s sslmode=%s TimeZone=%s",
		s.Host, s.User, s.Password, s.DBName, s.Addr, s.SSLMode, s.TimeZone,
	)

	DB, err = gorm.Open(postgres.New(postgres.Config{
		DSN: dsn,
	}), &gorm.Config{
		Logger: newLogger,
	})
	checkError(err)

	_ = DB.AutoMigrate(
		&models.Post{},
	)

}
