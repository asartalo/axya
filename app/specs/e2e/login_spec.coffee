'use strict'

describe "E2E: Logging in", ->
  homePage = new (require('./pages/home'))

  describe 'with incorrect credentials', ->

    beforeEach ->
      homePage.get()
      homePage.login("John", "WRONG")

    it 'should not go to dashboard', ->
      expect(browser.getCurrentUrl()).toNotContain('#/dashboard')

  describe 'with correct credentials', ->

    beforeEach ->
      homePage.get()
      homePage.login("Jane", "secret")

    it 'should go to dashboard', ->
      expect(browser.getCurrentUrl()).toContain('#/dashboard')

    it 'should remember user\'s name', ->
      expect(homePage.textContent()).toContain("Jane")

