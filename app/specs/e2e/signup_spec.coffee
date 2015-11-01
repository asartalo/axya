'use strict'

describe "E2E: Signing Up", ->
  signupPage = new (require('./pages/signup'))
  beforeEach ->
    signupPage.get()

  describe 'page', ->
    it 'exists', ->
      expect(signupPage.heading()).toContain("Signup")


