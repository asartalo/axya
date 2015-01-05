var conf = require('../config');

exports.config = {
  seleniumPort: 9879,
  framework: 'jasmine',
  seleniumArgs: ['throwOnCapabilityNotPresent=no'],
  // resultJsonOutputFile: conf.rootDir + "/protractorResults.json",
  specs: [conf.srcDir + "/specs/e2e/**/*_spec*.coffee"]
}
