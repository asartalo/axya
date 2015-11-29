"use strict"

angular.module 'axyaApp'
.controller 'DashboardCtrl', ($scope, Auth) ->
  $scope.user = Auth.currentUser()

