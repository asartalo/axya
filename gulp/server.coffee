"use strict"

# Module for starting/stopping go server

conf = require('../config')
spawn = require("child_process").spawn
gutil = require("gulp-util")
split = require("split")

module.exports = (->
  extend = (obj) ->
    i = 1

    while i < arguments.length
      for key of arguments[i]
        if Object::hasOwnProperty.call(arguments[i], key)
          obj[key] = arguments[i][key]
          obj[key] = ((if typeof arguments[i][key] is "object" and arguments[i][key] then extend(obj[key], arguments[i][key]) else arguments[i][key]))
      i++
    obj

  log = ->
    args = Array.prototype.slice.call(arguments)
    args.unshift "[#{gutil.colors.green('go server')}]"
    console.log.apply console, args

  server = (options) ->

    options = extend(
      bin: "bin/serve"
      port: 9876
      ready: ->
        #
    , options)
    args = [
      "--port"
      options.port
    ]

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

    cp

  server: server
)()
