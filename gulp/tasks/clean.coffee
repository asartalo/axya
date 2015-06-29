'use strict'

gulp = require('gulp')
del = require('del')
conf = require('../../config')(process.env.AXYA_ENV)

gulp.task 'clean', (done) ->
  console.log "CLEANING:", conf.publicDir
  del([
    "#{conf.publicDir}/*"
  ], done)

