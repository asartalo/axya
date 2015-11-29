'use strict'

module.exports = class

  get: ->
    if @pagePath == '/'
      browser.get(@pagePath)
      @pagePath
    else
      browser.get("#/#{@pagePath}")
    browser.waitForAngular()

  heading: ->
    element(By.css('.page-header')).getText()

  textContent: ->
    element(By.css('body')).getText()



