"use strict"

# Execute gulp commands on a separate process

_ = require('lodash')
spawn = require("child_process").spawn
gutil = require("gulp-util")
split = require("split")

log = ->
  args = Array.prototype.slice.call(arguments)
  args.unshift "[#{gutil.colors.green('prozes')}]"
  console.log.apply console, args

module.exports = (task, environment, done) ->
  env = _.extend {}, process.env, {'AXYA_ENV': environment}

  log "Running 'gulp #{task}' in a different process"
  cp = spawn('gulp', [task], env: env, stdio: 'inherit')

  cp.on 'close', (code, signal) ->
    log "Stopping 'gulp #{task}'"
    done()

  cp.stop = ->
    cp.kill('SIGINT')

  process.on 'SIGINT', ->
    cp.stop()
    process.exit()

  cp

