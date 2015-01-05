gulp = require("gulp")
gutil = require("gulp-util")
karma = require("karma").server
notifier = require('node-notifier')
plumber = require("gulp-plumber")
shell = require("gulp-shell")
split = require("split")
spawn = require("child_process").spawn

conf = require('../../config')

gulp.task "test:server", (done) ->
  gulp.src("").pipe shell(["go run serve/serve.go --port 9877"])
  done()

gulp.task "test:unit", (done) ->
  karma.start
    configFile: "../../../karma/karma_unit.conf.coffee"
    singleRun: true
  , done
  return

testNotify = (message, type = 'error') ->
  if type == 'error'
    color = 'red'
    title = "E2E Test Failure/Error"
  else
    color = 'green'
    title = "E2E Test Success"
  gutil.log gutil.colors[color](message)
  notifier.notify
    title: title
    message: message

gulp.task "test:e2e", ['test:server'], (done) ->
  cmd = conf.rootDir + '/node_modules/protractor/bin/protractor'
  prot = spawn(
    cmd,
    ['--baseUrl=http://127.0.0.1:9877', conf.rootDir + "/gulp/protractor.conf.js"]
  )

  prot.on 'close', (code) ->
    if code != 0
      gutil.log gutil.colors.red("protractor exited with code #{code}")
    done()

  prot.stdout.pipe(split()).on 'data', (line) ->
    if line.match /NoSuchElementError:/
      testNotify(line)
    else if m = line.match /\d+ tests?, \d+ assertions?, (\d+) failures?/
      if m[1] + 0 > 0
        testNotify(m[0])
      else
        testNotify(m[0], 'success')
    else
      gutil.log line

  prot.stderr.on 'data', (err) ->
    gutil.log gutil.colors.red(err)
    notifier.notify
      title: "E2E Test Failure/Error"
      message: err

gulp.task "tdd", ["test:e2e"]
