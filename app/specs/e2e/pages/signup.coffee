'use strict'
class SignupPage extends require('./base')
  constructor: ->
    @pagePath = 'signup'

  signUp: (name, password) ->
    @setName(name)
    @setPassword(password)
    browser.waitForAngular()
    @submit()

  setName: (name) ->
    $('#signup-name').sendKeys(name)

  setPassword: (password) ->
    $('#signup-password').sendKeys(password)

  submit: ->
    $('#signup-submit').click()
    browser.waitForAngular()

module.exports = SignupPage
