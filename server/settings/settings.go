// Settings file inspired by: https://github.com/eddycjy/go-gin-example/blob/master/pkg/setting/setting.go

package settings

import (
	"gopkg.in/ini.v1"
	"log"
	"time"
)

type Server struct {
	RunMode        string
	Addr           string
	ReadTimeout    time.Duration
	WriteTimeout   time.Duration
	MaxHeaderBytes int
}

var ServerSettings = &Server{}

type Postgres struct {
	User     string
	Password string
	Host     string
	DBName   string
	Addr     string
	SSLMode  string
	TimeZone string
}

var PostgresSettings = &Postgres{}

type Redis struct {
	Host        string
	Password    string
	MaxIdle     int
	MaxActive   int
	IdleTimeout time.Duration
}

var RedisSettings = &Redis{}

var cfg *ini.File

func InitSettings() {
	var err error
	cfg, err = ini.Load("conf/app.ini")
	if err != nil {
		log.Fatalf("setting.Setup, fail to parse 'conf/app.ini': %v", err)
	}

	mapTo("server", ServerSettings)
	mapTo("postgresql", PostgresSettings)
	mapTo("redis", RedisSettings)
	ServerSettings.ReadTimeout = ServerSettings.ReadTimeout * time.Second
	ServerSettings.WriteTimeout = ServerSettings.WriteTimeout * time.Second
	RedisSettings.IdleTimeout = RedisSettings.IdleTimeout * time.Second

}

func mapTo(section string, v interface{}) {
	err := cfg.Section(section).MapTo(v)
	if err != nil {
		log.Fatalf("Error while mapping to config of section: %v, \n %v", section, err)
	}
}
