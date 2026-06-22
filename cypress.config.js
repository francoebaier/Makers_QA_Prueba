require("dotenv").config();
const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    specPattern: [
      "cypress/e2e/**/*.cy.{js,jsx}",
      "api/automated-tests/**/*.cy.{js,jsx}",
    ],
    supportFile: "cypress/support/e2e.js",
    screenshotsFolder: "evidence/screenshots",
    videosFolder: "evidence/videos",
    video: false,
    screenshotOnRunFailure: true,
    defaultCommandTimeout: 10000,
    viewportWidth: 1280,
    viewportHeight: 720,
    setupNodeEvents(on, config) {
      // allure: habilitar después de correr npm install
      // const allureWriter = require("@shelex/cypress-allure-plugin/writer")
      // allureWriter(on, config)
      return config;
    },
  },
  env: {
    allure: false,
    REQRES_URL: process.env.REQUEST_URL,
    baseUrl: process.env.BASE_URL
  },
});
