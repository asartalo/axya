package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/asartalo/axya"
	"github.com/codegangsta/cli"
	"github.com/gin-gonic/gin"
)

func startServer(port int, dir string) {
	router := gin.Default()

	router.GET("/api", func(c *gin.Context) {
		c.String(http.StatusOK, "Hello GO API")
	})

	injector := axya.Injector(http.FileServer(http.Dir(dir)))
	injector.Inject("text/html", axya.InjectLiveReload)
	wrapedInjector := gin.WrapH(injector)
	router.GET("/components/*filepath", wrapedInjector)
	router.GET("/css/*filepath", wrapedInjector)
	router.GET("/js/*filepath", wrapedInjector)
	router.GET("/style-guide/*filepath", wrapedInjector)
	router.GET("/templates/*filepath", wrapedInjector)
	router.GET("/", wrapedInjector)

	// Do not remove the following line
	fmt.Println(fmt.Sprintf("Starting Server. Listening at port %d", port))

	router.Run(fmt.Sprintf(":%d", port))
}

func main() {
	app := cli.NewApp()
	app.Name = "server"
	app.Usage = "Starts the Axya server"
	app.Action = func(c *cli.Context) {
		startServer(c.Int(`port`), c.String(`dir`))
	}

	app.Flags = []cli.Flag{
		cli.IntFlag{
			Name:  "port, p",
			Value: 9876,
			Usage: "port where the server will listen to",
		},
		cli.StringFlag{
			Name:  "dir, d",
			Value: "./public",
			Usage: "directory of public files",
		},
	}

	app.Run(os.Args)
}
