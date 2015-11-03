describe "E2E: Home Page", ->
  homePage = new (require('./pages/home'))

  beforeEach ->
    homePage.get()

  it 'should display branding', ->
    expect(element(By.css('h1.branding')).getText()).toContain('Axya')

  it 'should hide sidebar', ->
    expect(element(By.css('#sidebar')).isPresent()).toBe(false)

  describe 'links', ->
    it 'should allow going to signup page', ->
      homePage.goToSignUp()
      expect(browser.getCurrentUrl()).toContain('#/signup')

