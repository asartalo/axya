gulp = require("gulp")
karma = require("karma").server

conf = require('../../../config')

gulp.task "test:unit", (done) ->
  karma.start
    configFile: "../../../karma/karma_unit.conf.coffee"
    singleRun: true
  , done
  return

