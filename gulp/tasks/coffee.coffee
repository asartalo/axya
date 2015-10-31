fs = require("fs")
browserify = require("browserify")
coffee = require("gulp-coffee")
gulp = require("gulp")
gulpif = require('gulp-if')
gutil = require("gulp-util")
livereload = require("gulp-livereload")
notifier = require('node-notifier')
source = require("vinyl-source-stream")

config = require('../../config')

coffeeTask = (files, conf) ->

  coffeeConfig =
    cache: {}
    packageCache: {}
    fullPaths: true
    entries: files
    extensions: [".coffee"]

  conf.debug = true  if conf.dev
  bundler = browserify(coffeeConfig)
  bundle = ->
    bundler.bundle().on("error", (error) ->
      gutil.log gutil.colors.red(error.message)
      notifier.notify
        title: "Coffeescript compilation error"
        message: error.message

      @emit "end"
      return
    ).pipe(source("app.js"))
      .pipe(gulp.dest(conf.publicDir + "/js"))
      .pipe(gulpif(conf.dev, livereload()))

  bundle()

gulp.task "coffee", ->
  conf = config(process.env.AXYA_ENV)
  files = [conf.srcDir + "/js/app.coffee"]
  componentsDir = conf.srcDir + "/components"
  fs.readdir(componentsDir, (err, directories) ->
    for d in directories
      fname = componentsDir + "/#{d}/index.coffee"
      if fs.existsSync(fname)
        console.log fname
        files.push fname
    console.log files
    coffeeTask(files, conf)
  )
