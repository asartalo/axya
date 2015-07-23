"use strict"

_ = require('lodash')

try
  localEnv = require('../local.env')
catch e
  localEnv = {}

envs =
  test:
    AXYA_ENV: 'test'
    AXYA_DB: './data_test.db'
  production:
    AXYA_ENV: 'production'
  development:
    AXYA_ENV: 'development'
    AXYA_DB: './data.db'
    # Use "github.com/gorilla/securecookie" bas64 encoded to generate keys
    AXYA_HASHKEY: 'NpSXuT5UPub9Fkzrmjmx23z1Swh5ZAH+OY3mSxExuQ5IG54FMphhB9rQC1ETRv+HQ78ZImVcs6OxQmNLD9LbRg=='
    AXYA_BLOCKKEY: 'K6rqSB5ZbmeiD8vLtyCM1de5VRhgxtQHe4+1Q+wngq0='
  all: localEnv

module.exports = (env = 'development') ->
  _.extend({}, process.env, envs.all, envs[env] || {})

