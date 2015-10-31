'use strict'

gulp = require("gulp")
gulpif = require("gulp-if")
sass = require('gulp-sass')
plumber = require('gulp-plumber')
concat = require('gulp-concat')
sourcemaps = require('gulp-sourcemaps')
livereload = require("gulp-livereload")
changed = require("gulp-changed")
path = require("path")

config = require('../../config')

# lessTask = (conf) ->
#   # This makes it easy to use sourcemaps with devtools
#
#   # Notify on error. Uses node-notifier
#   gulp.src(conf.srcDir + "/**/*.less")
#     .pipe(changed(conf.publicDir + "/"))
#     .pipe(less(
#       generateSourceMap: conf.dev
#       sourceMapBasepath: path.join(__dirname)
#       paths: [path.join(__dirname, "node_modules", "bootstrap", "less")]
#     ))
#     .pipe(plumber())
#     .pipe(gulp.dest(conf.publicDir + "/"))
#     .pipe gulpif(conf.dev, livereload())

gulp.task "sass", ->
  conf = config(process.env.AXYA_ENV)
  gulp.src([conf.srcDir + "/css/main.scss", conf.srcDir + "/components/**/*.scss"])
    .pipe(concat('main.scss'))
    # .pipe(changed(conf.publicDir + "/"))
    .pipe(sourcemaps.init())
    .pipe(sass().on('error', sass.logError))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(conf.publicDir + "/css"))
    .pipe gulpif(conf.dev, livereload())


