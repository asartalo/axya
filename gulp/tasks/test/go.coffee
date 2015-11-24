'use strict'

gulp = require("gulp")
shell = require('../../shell')

gulp.task "test:go", (done) ->
  shell('pwd')
  shell('ginkgo', ['-r'], callback: done)

# gulp.task "convey", shell.task(['goconvey --depth 2'])
