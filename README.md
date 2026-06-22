# Makers QA – Prueba Técnica

Solución completa a la prueba técnica de QA Engineer. Cubre los tres módulos requeridos: automatización UI sobre SauceDemo, documentación de testing funcional sobre MakersPay y pruebas de API sobre ReqRes.

---

## Stack

| Herramienta | Versión | Rol |
|---|---|---|
| [Cypress](https://www.cypress.io/) | 15.x | Framework de automatización (UI + API) |
| [Page Object Model](https://docs.cypress.io/guides/references/best-practices) | — | Patrón de diseño para tests UI |
| [Mochawesome](https://github.com/adamgruber/mochawesome) | 7.x | Reporte HTML de resultados |
| [dotenv](https://github.com/motdotla/dotenv) | 16.x | Variables de entorno |
| [ESLint + Prettier](https://eslint.org/) | 9.x | Calidad y formato de código |

---

## Estructura del proyecto

```
Makers_QA_Prueba/
│
├── cypress/
│   ├── e2e/
│   │   └── login/
│   │       └── logIn.cy.js          # Smoke tests de inicio de sesión (TC-001 – TC-011)
│   ├── fixtures/
│   │   ├── users.json               # Credenciales de prueba (SauceDemo)
│   │   └── api-data.json            # Payloads para tests de API
│   ├── pages/
│   │   ├── LogIn.js                 # Page Object – pantalla de login
│   │   └── Inventory.js             # Page Object – página de inventario
│   ├── reports/                     # Reportes Mochawesome generados
│   ├── support/
│   │   ├── commands.js              # cy.reqresRequest() y otros comandos custom
│   │   └── e2e.js                   # Entry point global
│   └── tsconfig.json                # Tipos de Cypress para IntelliSense
│
├── api/
│   └── automated-tests/
│       └── user-api.cy.js           # Tests de API (TC-API-001 – TC-API-015)
│
├── docs/
│   ├── functional-testing/          # Módulo 2 – Testing Funcional (MakersPay)
│   │   ├── test-strategy.md         # Estrategia, tipos y técnicas de prueba
│   │   ├── test-scenarios.md        # Escenarios de alto nivel
│   │   ├── test-cases.md            # Casos detallados con pasos y trazabilidad
│   │   └── bug-reports.md           # Plantilla + bug reports de ejemplo
│   └── testScenarios/
│       └── money-transfer.feature   # BDD en Gherkin – flujo de envío de dinero
│
├── evidence/                        # Screenshots y videos de ejecución
├── .vscode/
│   └── extensions.json              # Extensiones VS Code recomendadas
├── .env                             # Variables de entorno (ver sección abajo)
├── cypress.config.js
├── package.json
└── README.md
```

---

## Prerequisitos

| Requisito | Versión mínima | Verificar |
|---|---|---|
| Node.js | 18.x | `node -v` |
| npm | 9.x | `npm -v` |

---

## Instalación

```bash
npm install
```

> **Nota:** Si la red usa proxy o intercepta certificados SSL:
> ```powershell
> $env:NODE_TLS_REJECT_UNAUTHORIZED = "0"
> npm install
> ```

---

## Variables de entorno

El archivo `.env` en la raíz del proyecto contiene:

```
BASE_URL=https://www.saucedemo.com
REQUEST_URL=https://reqres.in/api
REQRES_API_KEY=free_user_3FVjmKYF6pQrgI3DsJDgw0GyhBY
```

### Obtener la API key de ReqRes

ReqRes requiere autenticación con `x-api-key`. La key es gratuita:

1. Ir a [app.reqres.in](https://app.reqres.in)
2. Crear una cuenta gratuita
3. Ir a **API Keys** y copiar la key
4. Pegarla en el `.env` como `REQRES_API_KEY=<tu_key>`

El header se inyecta automáticamente en todos los requests a través del comando custom `cy.reqresRequest()`.

---

## Ejecutar tests

```bash
# Abrir Cypress en modo interactivo
npm run test:open

# Todos los tests en modo headless
npm test

# Solo Smoke Tests de Login (SauceDemo)
npm run test:ui

# Solo API Tests (ReqRes)
npm run test:api

# Correr con navegador visible
npm run test:headed
```

---

## Reportes

```bash
# Fusionar resultados individuales y generar HTML
npm run report
```

El reporte queda en `cypress/reports/html/output.html`.

> Los pasos individuales también están disponibles:
> ```bash
> npm run report:merge     # Fusiona los JSON en cypress/reports/output.json
> npm run report:generate  # Genera el HTML desde el JSON fusionado
> ```

---

## Módulo 1 – Automatización UI (SauceDemo)

**URL:** https://www.saucedemo.com  
**Page Objects:** `cypress/pages/LogIn.js`, `cypress/pages/Inventory.js`  
**Fixtures:** `cypress/fixtures/users.json`  
**Spec:** `cypress/e2e/login/logIn.cy.js`

| ID | Caso de prueba | Tipo |
|---|---|---|
| TC-001 | La página de login carga correctamente | Smoke |
| TC-002 | Login exitoso con credenciales válidas | Happy path |
| TC-003 | Login fallido – contraseña incorrecta | Negativo |
| TC-004 | Login fallido – usuario bloqueado | Negativo |
| TC-005 | Validación – ambos campos vacíos | Campo obligatorio |
| TC-006 | Validación – campo password vacío | Campo obligatorio |
| TC-007 | Login fallido – usuario inexistente | Negativo opcional |
| TC-008 | Login fallido – contraseña con espacios | BVA opcional |
| TC-009 | Login fallido – contraseña en mayúsculas | Case-sensitive opcional |
| TC-010 | Cerrar mensaje de error y reintentar | Flujo recuperación opcional |
| TC-011 | Validación – usuario vacío con password ingresado | Campo obligatorio |

---

## Módulo 2 – Testing Funcional (MakersPay)

Producto ficticio: billetera digital con flujo de envío de dinero entre usuarios registrados.

| Archivo | Contenido |
|---|---|
| `docs/functional-testing/test-strategy.md` | Tipos de prueba, técnicas (EP, BVA, tabla de decisión), riesgos |
| `docs/functional-testing/test-scenarios.md` | Escenarios de alto nivel con prioridad y técnica aplicada |
| `docs/functional-testing/test-cases.md` | Casos detallados con precondiciones, pasos, resultado esperado y trazabilidad Gherkin |
| `docs/functional-testing/bug-reports.md` | Plantilla estándar + bug reports de ejemplo |
| `docs/testScenarios/money-transfer.feature` | Escenarios BDD en Gherkin (Given/When/Then) |

**Reglas de negocio cubiertas:**
- Monto mínimo $5.000 COP / máximo $2.000.000 COP
- Saldo insuficiente
- Autoenvío al propio número
- Actualización de saldos e historial post-transacción
- Integridad ante fallos y timeouts

---

## Módulo 3 – API Testing (ReqRes)

**Base URL:** `https://reqres.in/api`  
**Spec:** `api/automated-tests/user-api.cy.js`  
**Fixtures:** `cypress/fixtures/api-data.json`  
**Comando custom:** `cy.reqresRequest(options)` — inyecta URL base y `x-api-key` automáticamente

> **Nota:** ReqRes es una API mock. Los usuarios creados con `POST /users` no persisten en el dataset real (IDs disponibles: 1–12). El comportamiento está documentado en cada caso donde esto aplica.

| ID | Método | Endpoint | Escenario |
|---|---|---|---|
| TC-API-001 | POST | /users | Crear usuario → 201, body y Content-Type válidos |
| TC-API-002 | POST→GET | /users/{id} | Extraer id del POST y encadenar GET |
| TC-API-003 | POST | /users | Validar formato ISO 8601 de `createdAt` |
| TC-API-004 | POST | /users | Tiempo de respuesta < 3000ms |
| TC-API-005 | POST | /users | Sin campo `name` → 201 (comportamiento documentado) |
| TC-API-006 | POST | /users | Sin campo `job` → 201 (comportamiento documentado) |
| TC-API-007 | POST | /users | Body vacío → 201 (comportamiento documentado) |
| TC-API-008 | POST | /users | Tipos incorrectos → 201 (comportamiento documentado) |
| TC-API-009 | GET | /users?page=1 | Lista paginada → 200, estructura válida |
| TC-API-010 | GET | /users/2 | Usuario existente → 200, datos correctos |
| TC-API-011 | GET | /users/9999 | ID inexistente → 404 |
| TC-API-012 | GET | /users/abc | ID no numérico → 404 |
| TC-API-013 | PUT | /users/2 | Actualización completa → 200, `updatedAt` presente |
| TC-API-014 | PATCH | /users/2 | Actualización parcial → 200, campo correcto |
| TC-API-015 | DELETE | /users/2 | Eliminar → 204 sin cuerpo |
