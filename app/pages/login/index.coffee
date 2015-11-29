'use strict'

require './controller'
require './directive'

angular.module('axyaApp').config [
  '$stateProvider', '$urlRouterProvider',
  ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise('/')
    $stateProvider
      .state 'index',
        url: '/'
        templateUrl: 'pages/home/view.html'
      .state 'login',
        url: '/login'
        templateUrl: 'pages/login/form.html'
]
