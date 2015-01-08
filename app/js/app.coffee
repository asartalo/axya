'use strict'

angular = require('angular')
require('angular-ui-router')

app = angular.module('axyaApp', ['ui.router'])
require('../components/login')

app.config [
  '$stateProvider', '$urlRouterProvider',
  ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise('/')

    $stateProvider
      .state 'index',
        url: '/'
        templateUrl: 'components/home/view.html'
      .state 'login',
        url: '/login'
        templateUrl: 'components/login/login.html'
      .state 'dashboard',
        url: '/dashboard'
        templateUrl: 'components/dashboard/view.html'

]

