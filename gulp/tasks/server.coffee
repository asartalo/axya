gulp = require("gulp")
server = require("../server").server
conf = require('../../config')()

gulp.task "server", (done) ->
  server(
    port: conf.port,
    ready: ->
      done()
  )

