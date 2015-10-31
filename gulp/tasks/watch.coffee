gulp = require("gulp")
livereload = require("gulp-livereload")

# gulp.task "watch", ["build"], ->
gulp.task "watch", ->
  livereload.listen()
  gulp.watch "app/**/*.jade", ["jade"]
  gulp.watch "app/**/*.coffee", ["coffee"]
  gulp.watch "app/**/*.js", ["js"]
  gulp.watch "app/**/*.scss", ["sass"]
  gulp.watch "app/**/*.css", ["css"]
  # gulp.watch "app/**/*.*", ["tdd"]
  # gulp.watch "model/**/*.*", ["tdd"]
  gulp.watch "./**/*.go", ["reload"]
  return

