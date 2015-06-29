gulp = require("gulp")
server = require("../server").server
conf = require('../../config')()

cp = null

gulp.task "server", (done) ->
  cp = server(
    port: conf.port,
    ready: ->
      done()
  )

gulp.task "server:stop", (done) ->
  d = ->
    setTimeout(done, 300)
  cp.stop(d) if cp

