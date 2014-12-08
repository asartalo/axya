gulp = require("gulp")

conf = require('../config')

gulp.task "vendor_fonts", ->
  gulp.src("node_modules/bootstrap/fonts/**/*.*")
    .pipe(gulp.dest(conf.outputDir + "/fonts"))

