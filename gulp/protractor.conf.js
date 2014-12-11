var conf = require('../config');

exports.config = {
  seleniumPort: 9879,
  specs: [conf.srcDir + "/specs/e2e/**/*_spec*.coffee"]
}
