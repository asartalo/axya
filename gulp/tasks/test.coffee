gulp = require("gulp")
karma = require("karma").server
plumber = require("gulp-plumber")
protractor = require("gulp-protractor").protractor
webdriver_standalone = require("gulp-protractor").webdriver_standalone

conf = require('../../config')

gulp.task "test:unit", (done) ->
  karma.start
    configFile: "../../../karma/karma_unit.conf.coffee"
    singleRun: true
  , done
  return

gulp.task('webdriver_standalone', webdriver_standalone)
gulp.task "test:e2e", (done) ->

  gulp.src(conf.srcDir + "/specs/e2e/**/*_spec*.coffee")
    .pipe(protractor(
      configFile: conf.rootDir + "/gulp/protractor.conf.js",
      args: ['--baseUrl', 'http://127.0.0.1:9876']
    ))
    .on('error', (e) ->
      console.log e
    )

