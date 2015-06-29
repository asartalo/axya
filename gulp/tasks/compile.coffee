"use strict"

gulp = require("gulp")
shell = require("gulp-shell")
conf = require('../../config')()

gulp.task "compile", shell.task(["go build -o #{conf.outputDir}/serve server/serve.go"])

