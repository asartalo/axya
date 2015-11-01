'use strict'

xdescribe "E2E: Signing Up", ->
  homePage = new (require('./pages/home'))
  beforeEach ->
    homePage.get()

  # describe 'signup


