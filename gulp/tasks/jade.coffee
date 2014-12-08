gulp = require("gulp")
plumber = require("gulp-plumber")
jade = require("gulp-jade")
livereload = require("gulp-livereload")

conf = require('../config')

gulp.task "jade", ->
  gulp.src(conf.srcDir + "/**/*.jade")
    .pipe(plumber())
    .pipe(jade())
    .pipe(gulp.dest(conf.outputDir))
    .pipe(livereload())
