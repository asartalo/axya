'use strict'

describe "E2E: Signing Up", ->
  signupPage = new (require('./pages/signup'))

  beforeEach ->
    signupPage.get()

  describe 'page', ->
    it 'exists', ->
      expect(signupPage.heading()).toContain("Signup")

  describe 'signing up', ->
    userData = require('./data/user')
    user = userData()

    beforeEach ->
      signupPage.signUp(userData.name, userData.password)

    it 'logs in to dashboard', ->
      expect(browser.getCurrentUrl()).toContain('/dashboard')

    xit 'remembers user', ->
      element(By.css('dashboard-page').getText()).toContain('jane')


