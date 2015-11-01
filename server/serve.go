package main

import (
	server "github.com/asartalo/axyaserve"
	"github.com/asartalo/axyaserve/model"
	"github.com/codegangsta/cli"
	"os"
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
				model.CreateDb("./data.db")
			},
		},
	}

	app.Run(os.Args)
}
