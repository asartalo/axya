gulp = require("gulp")
gulpif = require("gulp-if")
livereload = require("gulp-livereload")

config = require('../../config')

cssTask = (conf) ->
  gulp.src(conf.srcDir + "/**/*.css")
    .pipe(gulp.dest(conf.outputDir + ""))
    .pipe(
      gulpif(conf.dev, livereload())
    )

gulp.task "css", ->
  cssTask(config())

gulp.task "css:test", ->
  cssTask(config('test'))

