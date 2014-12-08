gulp = require("gulp")
karma = require("karma").server

conf = require('../config')

gulp.task "test", (done) ->
  karma.start
    configFile: "../../../karma.conf.js"
    singleRun: true
  , done
  return

