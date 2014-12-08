path = require("path")
gulp = require("gulp")
gutil = require("gulp-util")
shell = require("gulp-shell")
jade = require("gulp-jade")
less = require("gulp-less-sourcemap")
gulpif = require("gulp-if")
coffee = require("gulp-coffee")
plumber = require("gulp-plumber")
source = require("vinyl-source-stream")
livereload = require("gulp-livereload")
notifier = new (require("node-notifier"))
karma = require("karma").server
browserify = require("browserify")
srcDir = "app"
env = process.env.NODE_ENV or "development"
dev = (env is "development")
prod = (env is "production")

outputDir = (if dev then "builds/development" else "builds/production")


gulp.task "jade", ->
  gulp.src(srcDir + "/**/*.jade")
    .pipe(plumber())
    .pipe(jade())
    .pipe(gulp.dest(outputDir))
    .pipe(livereload())

gulp.task "css", ->
  gulp.src(srcDir + "/**/*.css").pipe(gulp.dest(outputDir)).pipe gulpif(dev, livereload())


# For sourcemaps
gulp.task "less_copy", ->
  gulp.src(srcDir + "/**/*.less").pipe gulpif(dev, gulp.dest(outputDir))

gulp.task "less", ["less_copy"], ->

  # This makes it easy to use sourcemaps with devtools

  # Notify on error. Uses node-notifier
  gulp.src(srcDir + "/**/*.less").pipe(less(
    generateSourceMap: dev
    sourceMapBasepath: path.join(__dirname)
    paths: [path.join(__dirname, "node_modules", "bootstrap", "less")]
  )).on("error", (error) ->
    gutil.log gutil.colors.red(error.message)
    notifier.notify
      title: "Less compilation error"
      message: error.message

    return
  ).pipe(gulp.dest(outputDir)).pipe gulpif(dev, livereload())

gulp.task "vendor_fonts", ->
  gulp.src("node_modules/bootstrap/fonts/**/*.*").pipe gulp.dest(outputDir + "/fonts")

gulp.task "js", ->
  gulp.src(srcDir + "/**/*.js").pipe(gulp.dest(outputDir + "/")).pipe gulpif(dev, livereload())

gulp.task "coffee", ->
  config =
    cache: {}
    packageCache: {}
    fullPaths: true
    entries: ["./app/js/app.coffee"]
    extensions: [".coffee"]

  config.debug = true  if dev
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
    ).pipe(source("app.js")).pipe(gulp.dest(outputDir + "/js")).pipe livereload()

  bundle()

gulp.task "test", (done) ->
  karma.start
    configFile: __dirname + "/karma.conf.js"
    singleRun: true
  , done
  return

gulp.task "server", ->
  gulp.src("").pipe shell(["go run serve/serve.go"])

gulp.task "build", [
  "jade"
  "coffee"
  "js"
  "less"
  "css"
  "vendor_fonts"
]
gulp.task "watch", ["build"], ->
  livereload.listen()
  gulp.watch "app/**/*.jade", ["jade"]
  gulp.watch "app/**/*.coffee", ["coffee"]
  gulp.watch "app/**/*.js", ["js"]
  gulp.watch "app/**/*.less", ["less"]
  gulp.watch "app/**/*.css", ["css"]
  return

gulp.task "development", [
  "watch"
  "server"
]
