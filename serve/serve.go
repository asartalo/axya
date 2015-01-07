package main

import (
	"fmt"
	"github.com/asartalo/axya"
	"github.com/codegangsta/cli"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
)

func startServer(port int) {
	r := mux.NewRouter()
	// TODO: Move hardcoded root directory to a mor configurable parameter
	injector := axya.Injector(http.FileServer(http.Dir("./builds/development")))

	injector.Inject("text/html", axya.InjectLiveReload)
	r.PathPrefix("/").Handler(injector)
	http.Handle("/", r)

	fmt.Println(fmt.Sprintf("Starting Server. Listening at port %d", port))
	go func() {
		c := make(chan os.Signal, 10)
		signal.Notify(c, os.Interrupt, syscall.SIGTERM, syscall.SIGKILL)
		<-c
		fmt.Println("\nStopping Server...")
		os.Exit(0)
	}()
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", port), nil))
}

func main() {
	app := cli.NewApp()
	app.Name = "server"
	app.Usage = "Starts the Axya server"
	app.Action = func(c *cli.Context) {
		startServer(c.Int(`port`))
	}

	app.Flags = []cli.Flag{
		cli.IntFlag{
			Name:  "port, p",
			Value: 9876,
			Usage: "port where the server will listen to",
		},
	}

	app.Run(os.Args)
}
