'use strict'

angular = require('angular')
require('angular-ui-router')
require('angular-material')
require('angular-cookies')

app = angular.module('axyaApp', [
  'ui.router'
  'ngMaterial'
  'ngCookies'
])

require('../pages/login')
# require('../components/login')
# require('../components/dashboard')
