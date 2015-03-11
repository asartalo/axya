browserify = require("browserify")
coffee = require("gulp-coffee")
gulp = require("gulp")
gulpif = require('gulp-if')
gutil = require("gulp-util")
livereload = require("gulp-livereload")
notifier = require('node-notifier')
source = require("vinyl-source-stream")

config = require('../../config')

coffeeTask = (conf) ->
  coffeeConfig =
    cache: {}
    packageCache: {}
    fullPaths: true
    entries: [conf.srcDir + "/js/app.coffee"]
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
  coffeeTask(config())

gulp.task "coffee:test", ->
  coffeeTask(config('test'))

