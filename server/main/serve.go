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
	// app.Action = func(c *cli.Context) {
	// 	server.StartServer(c.Int(`port`), c.String(`dir`))
	// }

	app.Commands = []cli.Command{
		{
			Name:    "start",
			Aliases: []string{"s"},
			Usage:   "starts the server",
			Flags: []cli.Flag{
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
			},

			Action: func(c *cli.Context) {
				server.StartServer(c.Int(`port`), c.String(`dir`))
			},
		},
		{
			Name:    "createdb",
			Aliases: []string{"d"},
			Usage:   "creates database tables and whatnot",
			Action: func(c *cli.Context) {
				// TODO: make db name a shared variable
				models.CreateDb("./data.db")
			},
		},
		{
			Name:    "seed",
			Aliases: []string{"c"},
			Usage:   "seeds database with test data",
			Action: func(c *cli.Context) {
				server.SeedDb()
			},
		},
	}

	app.Run(os.Args)
}
