gulp = require("gulp")
gulpif = require("gulp-if")
livereload = require("gulp-livereload")
config = require('../../config')

jsTask = (env = 'development') ->
  conf = config(env)
  gulp.src(conf.srcDir + "/**/*.js")
    .pipe(gulp.dest(conf.publicDir + "/"))
    .pipe(gulpif(conf.dev, livereload()))

gulp.task "js", ->
  jsTask(process.env.AXYA_ENV)

gulp.task "js:test", ->
  jsTask("test")

