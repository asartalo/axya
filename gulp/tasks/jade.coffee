gulp = require("gulp")
# changed = require("gulp-changed")
newer = require("gulp-newer")
gulpif = require('gulp-if')
plumber = require("gulp-plumber")
jade = require("gulp-jade")
livereload = require("gulp-livereload")
config = require('../../config')

jadeTask = (env) ->
  conf = config(env)
  gulp.src(conf.srcDir + "/**/*.jade")
    # TODO: Figure out how to map .jade to .html files for newer match
    # .pipe(newer(conf.srcDir))
    .pipe(jade())
    .pipe(gulp.dest(conf.publicDir))
    .pipe(gulpif(conf.dev, livereload()))

gulp.task "jade", ->
  jadeTask(process.env.AXYA_ENV)

gulp.task "jade:test", ->
  jadeTask('test')

