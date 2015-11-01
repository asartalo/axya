describe "E2E: Home Page", ->
  homePage = new (require('./pages/home'))

  beforeEach ->
    homePage.get()

  it 'should display branding', ->
    expect(element(By.css('h1.branding')).getText()).toContain('Axya')

  describe 'navigation', ->
    it 'should allow going to signup page', ->
      homePage.goToSignUp()
      expect(browser.getCurrentUrl()).toContain('#/signup')

