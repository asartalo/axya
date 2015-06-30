"use strict"

spawn = require('child_process').spawn
gutil = require('gulp-util')

module.exports = (command, args, options) ->
  stdout = ''
  stderr = ''

  child = spawn(command, args, options)

  child.stdout.setEncoding 'utf8'
  child.stdout.on 'data', (data) ->
    stdout += data
    gutil.log data

  child.stderr.setEncoding 'utf8'
  child.stderr.on 'data', (data) ->
    stderr += data
    gutil.log gutil.colors.red(data)
    gutil.beep()

  child.on 'close', (code) ->
    gutil.log 'Done with exit code', code
    options.callback() if options.callback

