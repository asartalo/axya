"use strict"

angular.module 'axyaApp'
.controller 'LoginCtrl', ($scope, $state, Auth) ->
  $scope.user =
    name: null
    password: null

  $scope.login = (user) ->
    Auth.login(user).then(
      (resp) ->
        $state.go('dashboard')
      (err) ->
        console.log err, err.data
    )


