"use strict"

angular.module 'axyaApp'
.controller 'SignupCtrl', ($scope, $state) ->
  $scope.user =
    name: null
    password: null

  $scope.signup = (user) ->
    $state.go('dashboard')



