'use strict'

class Auth
  constructor: (@http, @cookieStore) ->

  signup: (user) ->
    @http.post('/api/users', user).then(
      (resp) =>
        @cookieStore.put('currentUser', resp.data.payload)
    )

  login: (user) ->
    @http.post('/api/login', user).then(
      (resp) =>
        @cookieStore.put('currentUser', resp.data.payload)
    )

  currentUser: ->
    @cookieStore.get('currentUser')

angular.module 'axyaApp'
.factory 'Auth', ($http, $cookieStore) ->
  new Auth($http, $cookieStore)

