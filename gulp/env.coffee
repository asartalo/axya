"use strict"

_ = require('lodash')

try
  localEnv = require('../local.env')
catch e
  localEnv = {}

envs =
  test:
    AXYA_ENV: 'test'
  production:
    AXYA_ENV: 'production'
  all: localEnv

module.exports = (env = 'development') ->
  _.extend({}, process.env, envs.all, envs[env] || {})

