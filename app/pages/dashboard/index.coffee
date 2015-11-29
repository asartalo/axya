require './dashboard.controller'

angular.module('axyaApp').config [
  '$stateProvider', '$urlRouterProvider',
  ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise('/')
    $stateProvider
      .state 'dashboard',
        url: '/dashboard'
        controller: 'DashboardCtrl'
        templateUrl: 'pages/dashboard/view.html'
]
