"use strict"

_ = require('lodash')

try
  localConfig = require('../local.env')
catch e
  localConfig = {}

envs =
  test:
    NODE_ENV: 'test'
  prod:
    NODE_ENV: 'production'
  all: localConfig

module.exports = (env = 'development') ->
  _.extend(process.env, envs[env] || {}, envs.all)

