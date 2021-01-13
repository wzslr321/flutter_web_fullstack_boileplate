package main

import(
	"github.com/wzslr321/routers"
	"gorm.io/gorm/utils/tests"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestPingRoute(t *testing.T) {
	router := routers.InitRouter()

	w := httptest.NewRecorder()
	req,_ := http.NewRequest("GET","/ping", nil)
	router.ServeHTTP(w,req)

	tests.AssertEqual(t,200,w.Code)
	tests.AssertEqual(t,"pong",w.Body.String())

}
