gulp = require("gulp")
gutil = require("gulp-util")
karma = require("karma").server
notifier = require('node-notifier')
split = require("split")
spawn = require("child_process").spawn
server = require("../server").server

conf = require('../../config')

webserver = null

gulp.task "test:server", (done) ->
  webserver = server(
    port: 9877,
    ready: ->
      done()
  )
  return

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
    if webserver
      webserver.kill('SIGINT')
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

  return

gulp.task "tdd", ["test:e2e"]
