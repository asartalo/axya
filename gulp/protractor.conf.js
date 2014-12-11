var conf = require('../config');

exports.config = {
  seleniumPort: 9879,
  framework: 'jasmine',
  specs: [conf.srcDir + "/specs/e2e/**/*_spec*.coffee"]
}
