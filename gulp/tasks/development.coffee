gulp = require("gulp")
runSequence = require('run-sequence')

gulp.task "development", (done) ->
  runSequence('build', 'watch', 'server', done)

