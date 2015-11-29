"use strict"

angular.module 'axyaApp'
.controller 'SignupCtrl', ($scope, $state, Auth) ->
  $scope.user =
    name: null
    password: null

  $scope.signup = (user) ->
    Auth.signup(user).then(
      (resp) ->
        $state.go('dashboard')
      (err) ->
        console.log err, err.data
    )

