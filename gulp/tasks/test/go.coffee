'use strict'

gulp = require("gulp")
shell = require("gulp-shell")

gulp.task "test:go", shell.task(['go test'])

gulp.task "convey", shell.task(['goconvey --depth 2'])

