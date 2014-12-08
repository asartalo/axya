sharedConfig = require(__dirname + '/karma_shared.conf')

module.exports = (config) ->
  conf = sharedConfig(config)
  conf.files = conf.files.concat([
    # spec test files
    "app/specs/unit/**/*.coffee"
  ])

  config.set(conf)
  return
