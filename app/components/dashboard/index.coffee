angular.module('axyaApp').config [
  '$stateProvider', '$urlRouterProvider',
  ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise('/')
    $stateProvider
      .state 'dashboard',
        url: '/dashboard'
        templateUrl: 'components/dashboard/view.html'
]
