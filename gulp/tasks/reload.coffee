gulp = require("gulp")
runSequence = require('run-sequence')

gulp.task "reload", ["server:stop"], (done) ->
  runSequence("compile", "server", done)

