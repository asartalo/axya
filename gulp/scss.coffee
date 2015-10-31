'use strict'

gulp = require('gulp')
gulpif = require("gulp-if")
sass = require('gulp-sass')
sourcemaps = require('gulp-sourcemaps')
path = require("path")
config = require('../../config')

gulp.task 'sass', ->
  conf = config(process.env.AXYA_ENV)
  gulp.src('./sass/**/*.scss')
    .pipe(changed(conf.publicDir + "/"))
    .pipe(sass().on('error', sass.logError))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(conf.publicDir + "/"))
    .pipe gulpif(conf.dev, livereload())

