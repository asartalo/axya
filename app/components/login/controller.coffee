"use strict"

angular.module 'axyaApp'
.controller 'LoginCtrl', ($scope, $state) ->
  $scope.user =
    name: null
    password: null

  $scope.login = (user) ->
    console.log 'going to dashboard...'
    $state.go('dashboard')


