gulp = require("gulp")
gulpif = require("gulp-if")
livereload = require("gulp-livereload")
config = require('../../config')

jsTask = (conf) ->
  gulp.src(conf.srcDir + "/**/*.js")
    .pipe(gulp.dest(conf.publicDir + "/"))
    .pipe(gulpif(conf.dev, livereload()))

gulp.task "js", ->
  jsTask(config())

gulp.task "js:test", ->
  jsTask(config('test'))

