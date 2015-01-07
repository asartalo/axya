describe "E2E: Testing Requests", ->
  beforeEach ->
    browser.get('/')
    browser.waitForAngular()

  it 'should display branding', ->
    expect(element(By.css('h1.branding')).getText()).toContain('Axya')

  describe 'when the user logs in', ->
    $('#inputUsername').sendKeys("John")
    $('#inputPassword').sendKeys("Secret")
    $('#login-submit-btn').click()

    it 'should go to the dashboard', ->
      expect(browser.getCurrentUrl()).toContain('#/dashboard')

