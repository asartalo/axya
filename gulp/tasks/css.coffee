gulp = require("gulp")
gulpif = require("gulp-if")
livereload = require("gulp-livereload")

config = require('../../config')

cssTask = (env) ->
  conf = config(env)
  gulp.src(conf.srcDir + "/**/*.css")
    .pipe(gulp.dest(conf.publicDir + ""))
    .pipe(
      gulpif(conf.dev, livereload())
    )

gulp.task "css", ->
  cssTask(process.env.AXYA_ENV)

gulp.task "css:test", ->
  cssTask("test")



