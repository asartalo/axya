"use strict"

gulp = require("gulp")
shell = require("gulp-shell")

gulp.task "compile", shell.task(["go build -o bin/serve serve/serve.go"])

