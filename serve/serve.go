package main

import (
	"fmt"
	"github.com/asartalo/axya"
	"github.com/codegangsta/cli"
	"github.com/codegangsta/negroni"
	"github.com/gorilla/mux"
	"net/http"
	"os"
)

func startServer(port int) {
	r := mux.NewRouter()
	// TODO: Move hardcoded root directory to a mor configurable parameter
	injector := axya.Injector(http.FileServer(http.Dir("./builds/development")))

	injector.Inject("text/html", axya.InjectLiveReload)
	r.PathPrefix("/").Handler(injector)

	n := negroni.New()
	n.UseHandler(r)

	fmt.Println(fmt.Sprintf("Starting Server. Listening at port %d", port))
	n.Run(fmt.Sprintf(":%d", port))
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
