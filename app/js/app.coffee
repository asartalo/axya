'use strict'

angular = require('angular')
require('angular-ui-router')
app = angular.module('axyaApp', ['ui.router'])

app.config [
  '$stateProvider', '$urlRouterProvider',
  ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise('/')

    $stateProvider
      .state 'index',
        url: '/'
        templateUrl: 'partials/home.html'
      .state 'login',
        url: '/login'
        templateUrl: 'partials/login.html'

]

