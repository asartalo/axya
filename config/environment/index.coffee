'use strict'

path = require('path')
_ = require('lodash')

# All configurations will extend these options

# Export the config object based on the NODE_ENV
module.exports = (environment) ->
  all =
    domain: process.env.DOMAIN
    env: process.env.AXYA_ENV
    dev:  false
    prod: false
    rootDir: path.normalize(__dirname + '/../..')
    srcDir: path.normalize(__dirname +  "/../../app")
    port: process.env.AXYA_PORT or 9876

  merged = _.merge(all, require('./' + environment) or {})
  merged.publicDir = merged.outputDir + '/public'

  merged

