package main

import (
	"fmt"
	"github.com/asartalo/axya"
	"github.com/gorilla/mux"
	"net/http"
	"os"
	"os/signal"
	"syscall"
)

func main() {

	r := mux.NewRouter()
	injector := axya.Injector(http.FileServer(http.Dir("./builds/development")))

	injector.Inject("text/html", axya.InjectLiveReload)
	r.PathPrefix("/").Handler(injector)
	http.Handle("/", r)

	fmt.Println("Starting Server")
	go func() {
		c := make(chan os.Signal, 10)
		signal.Notify(c, os.Interrupt, syscall.SIGTERM)
		<-c
		fmt.Println("\nStopping Server...")
		os.Exit(0)
	}()
	http.ListenAndServe(":9876", nil)
}
