'use strict'

gulp = require("gulp")
runSequence = require('run-sequence')

gulp.task "tdd", (done) ->
  runSequence("test:unit", "test:e2e", "test:go", done)

gulp.task "test", ["test:e2e", "test:unit", "test:go"]
