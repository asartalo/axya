gulp = require("gulp")
gulpif = require("gulp-if")
less = require("gulp-less-sourcemap")
livereload = require("gulp-livereload")
path = require("path")
plumber = require("gulp-plumber")

conf = require('../../config')

# For sourcemaps
gulp.task "less_copy", ->
  gulp.src(conf.srcDir + "/**/*.less")
    .pipe(
      gulpif(conf.dev, gulp.dest(conf.outputDir + ""))
    )

gulp.task "less", [], ->

  # This makes it easy to use sourcemaps with devtools

  # Notify on error. Uses node-notifier
  gulp.src(conf.srcDir + "/**/*.less")
    .pipe(less(
      generateSourceMap: conf.dev
      sourceMapBasepath: path.join(__dirname)
      paths: [path.join(__dirname, "node_modules", "bootstrap", "less")]
    ))
    .pipe(plumber())
    .pipe(
      (->
        gulp.dest(conf.outputDir + "/")
      )()
    )
    .pipe gulpif(conf.dev, livereload())


