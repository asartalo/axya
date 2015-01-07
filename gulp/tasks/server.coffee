gulp = require("gulp")
server = require("../server").server

gulp.task "server", (done) ->
  server(
    port: 9876,
    ready: ->
      done()
  )

