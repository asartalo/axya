'use strict'

describe "E2E: Signing Up", ->
  signupPage = new (require('./pages/signup'))

  beforeEach ->
    signupPage.get()

  describe 'page', ->
    it 'exists', ->
      expect(signupPage.heading()).toContain("Signup")

  describe 'signing up', ->
    newUser = require('./data/user')
    user = {}

    beforeEach ->
      user = newUser()
      signupPage.signUp(user.name, user.password)

    it 'logs in to dashboard', ->
      expect(browser.getCurrentUrl()).toContain('/dashboard')

    it 'remembers user', ->
      expect(signupPage.textContent()).toContain(user.name)


