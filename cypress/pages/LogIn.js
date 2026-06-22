export class LogIn {
  // Selectors (instance fields – accesibles como LogIn.usernameInput en tests)
  usernameInput = '[id="user-name"]'
  passwordInput = '[id="password"]'
  loginButton   = '[id="login-button"]'
  loginForm     = '[id="login_button_container"]'
  errorMsg      = '[data-test="error"]'
  logo          = '.login_logo'
  appLogo       = '.app_logo'

  // Methods
  visit() {
    return cy.env(['baseUrl']).then(({ baseUrl }) => {
      cy.visit(baseUrl)
    })
  }

  fillUsername(username) {
    cy.get(this.usernameInput).clear().type(username)
  }

  fillPassword(password) {
    cy.get(this.passwordInput).clear().type(password)
  }

  clickLogin() {
    cy.get(this.loginButton).click()
  }

  login(username, password) {
    this.fillUsername(username)
    this.fillPassword(password)
    this.clickLogin()
  }

  assertErrorMessage(text) {
    cy.get(this.errorMsg).should('be.visible').and('contain', text)
  }

  assertLoggedIn() {
    cy.url().should('include', '/inventory.html')
    cy.get(this.appLogo).should('be.visible')
  }
}

export default new LogIn()
