'use strict'

module.exports = class

  get: ->
    browser.get('/')

  setName: (name) ->
    $('#inputUsername').sendKeys(name)

  setPassword: (password) ->
    $('#inputPassword').sendKeys(password)

  login: (name, password) ->
    @setName(name)
    @setPassword(password)
    $('#login-submit-btn').click()
    browser.waitForAngular()

