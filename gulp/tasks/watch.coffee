gulp = require("gulp")
livereload = require("gulp-livereload")

gulp.task "watch", ["build"], ->
  livereload.listen()
  gulp.watch "app/**/*.jade", ["jade"]
  gulp.watch "app/**/*.coffee", ["coffee"]
  gulp.watch "app/**/*.js", ["js"]
  gulp.watch "app/**/*.less", ["less"]
  gulp.watch "app/**/*.css", ["css"]
  gulp.watch "app/**/*.*", ["tdd"]
  gulp.watch "model/**/*.*", ["tdd"]
  return

