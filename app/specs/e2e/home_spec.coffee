describe "E2E: Testing Requests", ->

  browser.get('/')

  it 'should display branding', ->
    expect(element(By.css('h1.branding')).getText()).toContain('Axya')

  describe 'when the user logs in', ->
    $('#inputUsername').sendKeys("John")
    $('#inputPassword').sendKeys("Secret")

