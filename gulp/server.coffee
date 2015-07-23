"use strict"

# Module for starting/stopping go server

_ = require('lodash')
spawn = require("child_process").spawn
gutil = require("gulp-util")
split = require("split")
conf = require('../config')()

module.exports = (->
  cp = null

  server = (options) ->
    if cp
      cp.stop()

    log = ->
      args = Array.prototype.slice.call(arguments)
      args.unshift "[#{gutil.colors.green(options.logLabel || 'go server')}]"
      console.log.apply console, args

    options = _.extend(
      bin: "#{conf.outputDir}/serve"
      port: 9876
      ready: ->
        #
    , options)
    args = [
      "--port"
      options.port
      "--dir"
      conf.publicDir
    ]
    options.env = _.extend process.env, options.env

    cp = spawn(options.bin, args, detached: true)
    hasStarted = false
    onlineCheck = setTimeout(
      ->
        unless hasStarted
          options.ready()
      3000
    )

    cp.stdout.pipe(split()).on 'data', (line) ->
      if line.match /^Starting Server/
        log gutil.colors.green(line)
        hasStarted = true
        clearTimeout(onlineCheck)
        options.ready()
      else
        log line

    cp.stderr.on 'data', (err) ->
      log gutil.colors.red(err)

    cp.on 'close', (code, signal) ->
      log "Server Stopped."

    cp.stop = (callback) ->
      cp.kill('SIGINT')
      # cp = null
      callback() if callback
      process.removeListener 'SIGINT', fullStop

    fullStop = ->
      cp.stop() if cp
      setTimeout(
        ->
          process.exit()
        1000
      )

    process.on 'SIGINT', fullStop

    cp

  server.stop = (done) ->
    return cp.stop(done) if cp && cp.stop
    done()

  server: server
)()

