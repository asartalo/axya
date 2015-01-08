describe "E2E: Home Page", ->
  browser.get('/')

  beforeEach ->
    browser.get('/')

  it 'should display branding', ->
    expect(element(By.css('h1.branding')).getText()).toContain('Axya')

