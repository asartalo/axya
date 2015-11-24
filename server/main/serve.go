package main

import (
	"os"

	server "github.com/asartalo/axya/server"
	"github.com/asartalo/axya/server/models"
	"github.com/codegangsta/cli"
)

func main() {
	app := cli.NewApp()
	app.Name = "server"
	app.Usage = "Starts the Axya server"
	app.Action = func(c *cli.Context) {
		server.StartServer(c.Int(`port`), c.String(`dir`))
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

	app.Commands = []cli.Command{
		{
			Name:    "createdb",
			Aliases: []string{"c"},
			Usage:   "creates database tables and whatnot",
			Action: func(c *cli.Context) {
				// TODO: make db name a shared variable
				models.CreateDb("./data.db")
			},
		},
	}

	app.Run(os.Args)
}
