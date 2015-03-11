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

gulp.task "build:test", [
  "compile"
  "jade:test"
  "coffee:test"
  "js:test"
  "less:test"
  "css:test"
  "vendor_fonts"
]

