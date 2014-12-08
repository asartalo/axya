gulp = require("gulp")
shell = require("gulp-shell")

gulp.task "server", ->
  gulp.src("").pipe shell(["go run serve/serve.go"])

