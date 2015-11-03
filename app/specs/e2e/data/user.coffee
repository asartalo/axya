'use strict'

_test_users = {}
k = 0

module.exports = (k) ->
  if k?
    k++
  _test_users[k] =
    name: "jane#{k}"
    password: "secret#{k}"

  _test_users[k]
