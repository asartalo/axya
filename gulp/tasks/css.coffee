gulp = require("gulp")
gulpif = require("gulp-if")
livereload = require("gulp-livereload")

conf = require('../../config')

gulp.task "css", ->
  gulp.src(conf.srcDir + "/**/*.css")
    .pipe(gulp.dest(conf.outputDir + ""))
    .pipe(
      gulpif(conf.dev, livereload())
    )
