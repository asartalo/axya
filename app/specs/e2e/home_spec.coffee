describe "E2E: Testing Requests", ->

  beforeEach ->
    browser.get('/')

  it 'should display branding', ->
    expect(element(By.css('h1.branding')).getText()).toContain('Axya')

