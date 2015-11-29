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

coffeeRunner = (env = 'development') ->
  conf = config(env)
  files = [conf.srcDir + "/js/app.coffee"]
  include("/components", conf, files, ->
    include( "/pages", conf, files, ->
      coffeeTask(files, conf)
    )
  )

include = (directory, conf, files, callback) ->
  componentsDir = conf.srcDir + directory
  fs.readdir(componentsDir, (err, directories) ->
    for d in directories
      fname = componentsDir + "/#{d}/index.coffee"
      if fs.existsSync(fname)
        files.push fname
    callback() if callback
  )

gulp.task "coffee", ->
  coffeeRunner(process.env.AXYA_ENV)

gulp.task "coffee:test", ->
  coffeeRunner('test')

