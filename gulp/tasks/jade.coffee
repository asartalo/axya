gulp = require("gulp")
gulpif = require('gulp-if')
plumber = require("gulp-plumber")
jade = require("gulp-jade")
livereload = require("gulp-livereload")
config = require('../../config')

jadeTask = (conf) ->
  gulp.src(conf.srcDir + "/**/*.jade")
    .pipe(plumber())
    .pipe(jade())
    .pipe(gulp.dest(conf.outputDir))
    .pipe(gulpif(conf.dev, livereload()))

gulp.task "jade", ->
  jadeTask(config())

gulp.task "jade:test", ->
  jadeTask(config('test'))

