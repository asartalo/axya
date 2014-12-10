gulp = require("gulp")
gulpif = require("gulp-if")
livereload = require("gulp-livereload")

conf = require('../../config')

gulp.task "js", ->
  gulp.src(conf.srcDir + "/**/*.js")
    .pipe(gulp.dest(conf.outputDir + "/"))
    .pipe(gulpif(conf.dev, livereload()))

