gulp = require("gulp")
gutil = require("gulp-util")
notifier = require('node-notifier')
split = require("split")
spawn = require("child_process").spawn
server = require("../../server").server

conf = require('../../../config')('test')

webserver = null

gulp.task "test:server", (done) ->
  webserver = server(
    port: conf.port,
    env: require('../../env')('test')
    logLabel: 'test server',
    ready: ->
      setTimeout(
        ->
          console.log 'Test Server Ready'
          done()
        2000
      )
  )
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
    ["--baseUrl=http://127.0.0.1:#{conf.port}", conf.rootDir + "/gulp/protractor.conf.js"]
  )

  prot.on 'close', (code) ->
    error = null
    if code != 0
      gutil.log gutil.colors.red("protractor exited with code #{code}")
      error = { message: "E2E Test failure" }
    if webserver
      webserver.stop()
    done(error)

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

