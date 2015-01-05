browserify = require("browserify")
coffee = require("gulp-coffee")
gulp = require("gulp")
gutil = require("gulp-util")
livereload = require("gulp-livereload")
notifier = require('node-notifier')
source = require("vinyl-source-stream")

conf = require('../../config')

gulp.task "coffee", ->
  config =
    cache: {}
    packageCache: {}
    fullPaths: true
    entries: [conf.srcDir + "/js/app.coffee"]
    extensions: [".coffee"]

  conf.debug = true  if conf.dev
  bundler = browserify(config)
  bundle = ->

    # Report compile errors

    # Notify on error. Uses node-notifier

    # Use vinyl-source-stream to make the
    # stream gulp compatible. Specifiy the
    # desired output filename here.

    # Specify the output destination
    bundler.bundle().on("error", (error) ->
      gutil.log gutil.colors.red(error.message)
      notifier.notify
        title: "Coffeescript compilation error"
        message: error.message

      @emit "end"
      return
    ).pipe(source("app.js"))
      .pipe(gulp.dest(conf.outputDir + "/js"))
      .pipe(livereload())

  bundle()

