gulp = require("gulp")

gulp.task "build", [
  "compile"
  "jade"
  "coffee"
  "js"
  "less"
  "css"
  "vendor_fonts"
]

