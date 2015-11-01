'use strict'

gulp = require("gulp")
runSequence = require('run-sequence')
prozes = require('../prozes')

gulp.task "tdd-standalone", (done) ->
  runSequence("test:unit", "test:e2e", done)

gulp.task "tdd", (done) ->
  prozes('tdd-standalone', 'test', done)

gulp.task "test-standalone", (done) ->
  runSequence("build:test", ["test:e2e", "test:unit"], done)

gulp.task "test", (done) ->
  prozes('test-standalone', 'test', done)

