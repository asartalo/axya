'use strict'

_test_users = {}
k = 0

newUser = (i) ->
  _test_users["#{i}"] =
    name: "jane#{i}"
    password: "secret#{i}"
  _test_users["#{i}"]

hasUser = (i) ->
  !!_test_users["#{i}"]

getUser = (i) ->
  _test_users["#{i}"]

module.exports = (i) ->
  if i?
    if hasUser(i)
      return getUser(i)
    else
      return newUser(i)
  else
    k++
    if hasUser(k)
      return getUser(k)
    else
      return newUser(k)

