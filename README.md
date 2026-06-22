# Makers QA – Prueba Técnica

Solución completa a la prueba técnica de QA Engineer. Cubre los tres módulos requeridos: automatización UI sobre SauceDemo, documentación de testing funcional sobre MakersPay y pruebas de API sobre ReqRes.

---

## Stack

| Herramienta | Rol |
|---|---|
| [Cypress 13](https://www.cypress.io/) | Framework de automatización (UI + API) |
| [Page Object Model](https://docs.cypress.io/guides/references/best-practices#Organizing-Tests) | Patrón de diseño para tests UI |
| [@shelex/cypress-allure-plugin](https://github.com/Shelex/cypress-allure-plugin) | Reporte Allure integrado con Cypress |
| [allure-commandline](https://github.com/allure-framework/allure2) | Generación de reporte HTML interactivo |
| [Mochawesome](https://github.com/adamgruber/mochawesome) | Reporte HTML alternativo |
| [cypress-plugin-api](https://github.com/filiphric/cypress-plugin-api) | UI mejorada para tests de API |
| [dotenv](https://github.com/motdotla/dotenv) | Variables de entorno |
| [ESLint + Prettier](https://eslint.org/) | Calidad y formato de código |

---

## Estructura del proyecto

```
Makers_QA_Prueba/
│
├── automation/                        # Módulo 1 – Automatización UI (SauceDemo)
│   ├── cypress/support/e2e.js        # Entry point global de Cypress
│   ├── fixtures/
│   │   └── users.json                # Datos de prueba (credenciales)
│   ├── pages/
│   │   └── LoginPage.js              # Page Object – pantalla de login
│   └── tests/
│       └── login.cy.js               # Smoke tests de inicio de sesión
│
├── api/                               # Módulo 3 – API Testing (ReqRes)
│   ├── postman/                      # Colección Postman de referencia
│   └── automated-tests/
│       └── reqres-users.cy.js        # Tests automatizados con Cypress
│
├── functional-testing/                # Módulo 2 – Testing Funcional (MakersPay)
│   ├── test-strategy.md              # Estrategia, tipos y técnicas de prueba
│   ├── test-scenarios.md             # Escenarios de alto nivel
│   ├── test-cases.md                 # Casos de prueba detallados
│   └── bug-reports.md                # Plantilla y ejemplos de bug reports
│
├── evidence/                          # Screenshots y videos generados al correr tests
├── cypress.config.js                  # Configuración de Cypress
├── package.json
└── README.md
```

---

## Prerequisitos

| Requisito | Versión mínima | Verificar |
|---|---|---|
| Node.js | 18.x | `node -v` |
| npm | 9.x | `npm -v` |
| Java (JDK/JRE) | 8+ | `java -version` |

> Java es requerido por `allure-commandline` para generar el reporte HTML.
> Descargarlo desde [https://adoptium.net/](https://adoptium.net/)

---

## Instalación

```bash
npm install
```

> **Nota:** Si tu red usa un proxy o intercepta certificados SSL, corré primero:
> ```powershell
> $env:NODE_TLS_REJECT_UNAUTHORIZED = "0"
> npm install
> ```

---

## Ejecutar tests

```bash
# Abrir Cypress en modo interactivo (recomendado para desarrollo)
npm run test:open

# Todos los tests en modo headless
npm test

# Solo Smoke Tests de Login – SauceDemo
npm run test:ui

# Solo API Tests – ReqRes
npm run test:api

# Correr con navegador visible
npm run test:headed
```

---

## Reportes

### Allure (HTML interactivo)

Requiere haber corrido los tests con `allure=true` en las env vars (ya configurado en `cypress.config.js`).

```bash
# Generar reporte HTML desde los resultados
npm run allure:generate

# Abrir el reporte en el browser
npm run allure:open

# Generar y abrir en un solo paso
npm run allure:serve

# Limpiar resultados anteriores
npm run allure:clean
```

El reporte queda en `allure-report/index.html`.

### Mochawesome (HTML estático)

```bash
# Fusionar JSONs individuales por spec
npm run report:merge

# Generar HTML final
npm run report:generate

# Todo en uno
npm run report
```

El reporte queda en `cypress/reports/html/output.html`.

---

## Módulo 1 – Automatización UI (SauceDemo)

**URL bajo prueba:** https://www.saucedemo.com  
**Credenciales de prueba:** definidas en `automation/fixtures/users.json`

| ID | Caso de prueba | Tipo |
|---|---|---|
| TC-001 | Login exitoso con credenciales válidas | Happy path / Smoke |
| TC-002 | Login fallido – contraseña incorrecta | Negativo |
| TC-003 | Login fallido – usuario inválido | Negativo |
| TC-004 | Login fallido – usuario bloqueado | Negativo |
| TC-005 | Validación – ambos campos vacíos | Campo obligatorio |
| TC-006 | Validación – campo password vacío | Campo obligatorio |
| TC-007 | Validación – campo username vacío | Campo obligatorio |

**Patrón:** Page Object Model → `automation/pages/LoginPage.js`

---

## Módulo 2 – Testing Funcional (MakersPay)

Producto ficticio: billetera digital con flujo de envío de dinero entre usuarios.

Documentación completa en `functional-testing/`:

| Archivo | Contenido |
|---|---|
| `test-strategy.md` | Tipos de prueba, técnicas (EP, BVA, casos de uso), riesgos |
| `test-scenarios.md` | 12 escenarios de alto nivel con prioridad |
| `test-cases.md` | 13 casos detallados con precondiciones, pasos y resultado esperado |
| `bug-reports.md` | Plantilla estándar + 3 bug reports de ejemplo |

**Técnicas aplicadas:** Partición de equivalencia, Análisis de valores límite (BVA), Casos de uso.

**Reglas de negocio cubiertas:**
- Monto mínimo: $5.000 COP
- Monto máximo: $2.000.000 COP
- Sin saldo insuficiente
- Sin autoenvío al propio número
- Actualización de saldos y registro en historial post-transacción

---

## Módulo 3 – API Testing (ReqRes)

**Base URL:** `https://reqres.in/api`

| ID | Método | Endpoint | Escenario |
|---|---|---|---|
| TC-API-001 | POST | /users | Crear usuario → 201 + id + datos |
| TC-API-002 | POST → GET | /users / /users/{id} | Flujo crear y consultar |
| TC-API-003 | GET | /users?page=1 | Listar usuarios paginados → 200 |
| TC-API-004 | GET | /users/9999 | Usuario inexistente → 404 |
| TC-API-005 | GET | /users?page=999 | Página vacía → array vacío |
| TC-API-006 | PUT | /users/2 | Actualización completa → 200 + updatedAt |
| TC-API-007 | PATCH | /users/2 | Actualización parcial → 200 |
| TC-API-008 | DELETE | /users/2 | Eliminar → 204 sin body |
| TC-API-009 | POST | /login | Login exitoso → token |
| TC-API-010 | POST | /login | Login sin password → 400 |
| TC-API-011 | POST | /register | Register exitoso → id + token |
| TC-API-012 | POST | /register | Register sin password → 400 |

---

## CI/CD

El workflow `.github/workflows/ci.yml` se ejecuta en cada push/PR contra `main` y `develop`:

1. Instala dependencias
2. Corre tests de UI (SauceDemo)
3. Corre tests de API (ReqRes)
4. Sube screenshots y videos como artefactos en caso de fallo

---

## Variables de entorno

Definidas en `cypress.config.js` bajo la clave `env`. Para sobrescribir en tiempo de ejecución:

```bash
npx cypress run --env API_BASE_URL=https://mi-api.com
```

Para usar un archivo `.env`, el proyecto incluye `dotenv`. Creá un `.env` en la raíz:

```
CYPRESS_API_BASE_URL=https://reqres.in/api
CYPRESS_SAUCEDEMO_URL=https://www.saucedemo.com
```
