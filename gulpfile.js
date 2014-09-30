var path = require('path'),
    gulp = require('gulp'),
    gutil = require('gulp-util'),
    shell = require('gulp-shell'),
    jade = require('gulp-jade'),
    less = require('gulp-less-sourcemap'),
    gulpif = require('gulp-if'),
    coffee = require('gulp-coffee'),
    source = require('vinyl-source-stream'),
    livereload = require('gulp-livereload'),
    notifier = new (require('node-notifier')),
    browserify = require('browserify');

var srcDir = 'app',
    env = process.env.NODE_ENV || 'development',
    dev = (env == 'development'),
    prod = (env == 'production'),
    outputDir = dev ? 'builds/development' : 'builds/production';

gulp.task('jade', function() {
  return gulp.src(srcDir + '/templates/**/*.jade')
    .pipe(jade())
    .pipe(gulp.dest(outputDir))
    .pipe(livereload());
});

gulp.task('css', function() {
  return gulp.src(srcDir + '/css/**/*.css')
    .pipe(gulp.dest(outputDir + '/css'))
    .pipe(gulpif(dev, livereload()));
});

gulp.task('less_copy', function() {
  return gulp.src(srcDir + '/css/**/*.less')
    .pipe(gulpif(dev, gulp.dest(outputDir + '/css')));
});

gulp.task('less', ['less_copy'], function() {
  return gulp.src(srcDir + '/css/*.less')
    .pipe(less({
      generateSourceMap: dev,
      // This makes it easy to use sourcemaps with devtools
      sourceMapBasepath: path.join(__dirname),
      paths: [
        path.join(__dirname, 'node_modules', 'bootstrap', 'less')
      ]
    }))
    .on('error', function (error) {
      gutil.log(gutil.colors.red(error.message))
      // Notify on error. Uses node-notifier
      notifier.notify({
        title: 'Less compilation error',
        message: error.message
      });
    })
    .pipe(gulp.dest(outputDir + '/css'))
    .pipe(gulpif(dev, livereload()));
});

gulp.task('vendor_fonts', function() {
  return gulp.src('node_modules/bootstrap/fonts/**/*.*')
    .pipe(gulp.dest(outputDir + '/fonts'));
});

gulp.task('js', function() {
  return gulp.src(srcDir + '/js/**/*.js')
    .pipe(gulp.dest(outputDir + '/js'))
    .pipe(gulpif(dev, livereload()));
});

gulp.task('coffee', function() {
  var config = {
    cache: {}, packageCache: {}, fullPaths: true,
    entries: ['./app/js/app.coffee'],
    extensions: ['.coffee']
  };

  if (dev) {
    config.debug = true;
  }

  var bundler = browserify(config);

  var bundle = function() {
    return bundler
      .bundle()
      // Report compile errors
      .on('error', function (error) {
        gutil.log(gutil.colors.red(error.message))
        // Notify on error. Uses node-notifier
        notifier.notify({
          title: 'Coffeescript compilation error',
          message: error.message
        });
        this.emit('end');
      })
      // Use vinyl-source-stream to make the
      // stream gulp compatible. Specifiy the
      // desired output filename here.
      .pipe(source('app.js'))
      // Specify the output destination
      .pipe(gulp.dest(outputDir + '/js'))
      .pipe(livereload());
  };

  return bundle();
});

gulp.task('server', function() {
  return gulp.src('')
    .pipe(shell(['go run serve/serve.go']));
});

gulp.task('build', ['jade', 'coffee', 'js', 'less', 'css', 'vendor_fonts']);

gulp.task('watch', ['build'], function() {
  livereload.listen();
  gulp.watch('app/templates/**/*.jade', ['jade']);
  gulp.watch('app/js/**/*.coffee', ['coffee']);
  gulp.watch('app/js/**/*.js', ['js']);
  gulp.watch('app/css/**/*.less', ['less']);
  gulp.watch('app/css/**/*.css', ['css']);
});

gulp.task('development', ['watch', 'server']);
