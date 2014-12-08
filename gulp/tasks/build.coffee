gulp = require("gulp")

gulp.task "build", [
  "jade"
  "coffee"
  "js"
  "less"
  "css"
  "vendor_fonts"
]

