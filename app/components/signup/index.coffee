'use strict'

require './controller'

angular.module('axyaApp').config [
  '$stateProvider', '$urlRouterProvider',
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state 'signup',
        url: '/signup'
        controller: 'SignupCtrl'
        templateUrl: 'components/signup/view.html'
]

