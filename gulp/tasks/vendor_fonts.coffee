gulp = require("gulp")

conf = require('../../config')(process.env.AXYA_ENV)

gulp.task "vendor_fonts", ->
  gulp.src("node_modules/bootstrap/fonts/**/*.*")
    .pipe(gulp.dest(conf.publicDir + "/fonts"))

