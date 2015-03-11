'use strict'

gulp = require("gulp")
runSequence = require('run-sequence')

gulp.task "tdd", (done) ->
  runSequence("test:go", "test:unit", "test:e2e", done)

gulp.task "test", (done) ->
  runSequence("build:test", ["test:e2e", "test:unit", "test:go"], done)
