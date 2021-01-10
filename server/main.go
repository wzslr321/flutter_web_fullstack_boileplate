package main

import (
	"context"
	"github.com/wzslr321/database/postgres"
	"github.com/wzslr321/database/redis"
	"github.com/wzslr321/routers"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"
)

func main() {

	postgres.InitDB()
	redis.InitializeRedis()

	router := routers.InitRouter()

	s := &http.Server{
		Addr: ":8000",
		Handler: router,
		ReadTimeout: 10 * time.Second,
		WriteTimeout: 10 * time.Second,
		MaxHeaderBytes: 1 << 20,
	}

	go func() {
		if err := s.ListenAndServe() ;err != nil && err != http.ErrServerClosed {
			log.Fatalf("Listen: %s\n", err)
		}
	}()

	quit := make(chan os.Signal)

	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
	<-quit
	log.Println("Shutting down the server...")

	ctx,cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := s.Shutdown(ctx); err != nil {
		log.Fatal("Server shutdown", err)
	}

	select {
		case <- ctx.Done():
			log.Println("Timeout of 5 seconds")
	}
	log.Println("Server exiting")


}


