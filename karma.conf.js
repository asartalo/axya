// Karma configuration
// Generated on Thu Dec 04 2014 03:52:41 GMT+0800 (PHT)

module.exports = function(config) {
  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: __dirname,


    // frameworks to use
    // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['browserify', 'jasmine'],


    browserify: {
      // extensions: ['.coffee'],
      // transform: ['coffeeify'],
      debug: true
    },


    // list of files / patterns to load in the browser
    files: [
      'app/**/*.coffee'
    ],


    // list of files to exclude
    exclude: [
    ],


    // preprocess matching files before serving them to the browser
    // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
      // 'app/js/**/*.coffee': ['coffee'],
      'app/**/*.coffee': ['browserify'],
      '**/*.jade': ['ng-jade2js']
    },

    ngJade2JsPreprocessor: {
      // strip this from the file path
      stripPrefix: 'app/templates/'
      // prepend this to the
      // prependPrefix: 'served/',
    },


    // test results reporter to use
    // possible values: 'dots', 'progress'
    // available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress'],


    // web server port
    port: 9877,


    // enable / disable colors in the output (reporters and logs)
    colors: true,


    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: false,


    // start these browsers
    // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['PhantomJS'],


    // Continuous Integration mode
    // if true, Karma captures browsers, runs the tests and exits
    singleRun: false
  });
};
