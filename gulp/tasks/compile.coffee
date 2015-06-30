"use strict"

gulp = require("gulp")
shell = require('../shell')
conf = require('../../config')()

gulp.task "compile", (done) ->
  shell(
    "go"
    [
      "build"
      "-o"
      "#{conf.outputDir}/serve"
      "server/serve.go"
    ]
    callback: done
  )

