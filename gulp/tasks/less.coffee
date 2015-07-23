gulp = require("gulp")
gulpif = require("gulp-if")
less = require("gulp-less-sourcemap")
livereload = require("gulp-livereload")
changed = require("gulp-changed")
plumber = require("gulp-plumber")
path = require("path")

config = require('../../config')

lessTask = (conf) ->
  # This makes it easy to use sourcemaps with devtools

  # Notify on error. Uses node-notifier
  gulp.src(conf.srcDir + "/**/*.less")
    .pipe(changed(conf.publicDir + "/"))
    .pipe(less(
      generateSourceMap: conf.dev
      sourceMapBasepath: path.join(__dirname)
      paths: [path.join(__dirname, "node_modules", "bootstrap", "less")]
    ))
    .pipe(plumber())
    .pipe(gulp.dest(conf.publicDir + "/"))
    .pipe gulpif(conf.dev, livereload())

gulp.task "less", ->
  lessTask(config(process.env.AXYA_ENV))

