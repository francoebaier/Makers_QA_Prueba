/// <reference types="cypress" />
import LogIn from '../../pages/LogIn'

describe('Login Page – SauceDemo', () => {

    beforeEach(() => {
        LogIn.visit()
    })

    it('TC-001 | La página de login carga correctamente', () => {
        cy.get(LogIn.usernameInput).should('be.visible')
        cy.get(LogIn.passwordInput).should('be.visible')
        cy.get(LogIn.loginButton).should('be.visible').and('have.value', 'Login')
    })

    //Happy path

    it('TC-002 | Login exitoso con usuario válido', () => {
        cy.fixture('users').then(({ validUser }) => {
            cy.get(LogIn.usernameInput).click().type(validUser.username)
            cy.get(LogIn.passwordInput).click().type(validUser.password)
        });
        cy.get(LogIn.loginButton).click();
    })

    // Casos negativos 

    it('TC-003 | Login fallido con contraseña incorrecta', () => {
        cy.fixture('users').then(({ validUser, wrongPassword }) => {
            cy.get(LogIn.usernameInput).click().type(validUser.username)
            cy.get(LogIn.passwordInput).click().type(wrongPassword.password)
            cy.get(LogIn.loginButton).click()
            cy.get(LogIn.errorMsg)
                .should('be.visible')
                .and('contain', 'Epic sadface: Username and password do not match any user in this service')
        })
    })

    it('TC-004 | Login fallido con usuario bloqueado', () => {
        cy.fixture('users').then(({ lockedUser }) => {
            LogIn.login(lockedUser.username, lockedUser.password)
            cy.get(LogIn.errorMsg)
                .should('be.visible')
                .and('contain', 'Epic sadface: Sorry, this user has been locked out.')
        })
    })

    // Campos obligatorios 

    it('TC-005 | Error al enviar formulario sin credenciales', () => {
        LogIn.clickLogin()
        LogIn.assertErrorMessage('Username is required')
    })

    it('TC-006 | Error al enviar sin password', () => {
        cy.fixture('users').then(({ validUser }) => {
            LogIn.fillUsername(validUser.username)
            LogIn.clickLogin()
            LogIn.assertErrorMessage('Password is required')
        })
    })

})
