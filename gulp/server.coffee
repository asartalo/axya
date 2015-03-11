"use strict"

# Module for starting/stopping go server

_ = require('lodash')
conf = require('../config')
spawn = require("child_process").spawn
gutil = require("gulp-util")
split = require("split")
conf = require('../config')()

module.exports = (->

  server = (options) ->

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

    cp.stdout.pipe(split()).on 'data', (line) ->
      if line.match /^Starting Server/
        log gutil.colors.green(line)
        options.ready()
      else
        log line

    cp.stderr.on 'data', (err) ->
      log gutil.colors.red(err)

    cp.on 'close', (code, signal) ->
      log "Server Stopped."

    cp.stop = ->
      cp.kill('SIGINT')

    process.on 'SIGINT', ->
      cp.stop()
      setTimeout(
        ->
          process.exit()
        1000
      )

    cp

  server: server
)()

