require('coffee-script/register');
_ = require('lodash');

_.extend(process.env, require('./gulp/env')('development') || {});
// Require all tasks in gulp/tasks, including subfolders
require('node-require-directory')('./gulp/tasks');

