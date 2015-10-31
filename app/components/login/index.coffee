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
        templateUrl: 'components/home/view.html'
      .state 'login',
        url: '/login'
        templateUrl: 'components/login/form.html'
]
