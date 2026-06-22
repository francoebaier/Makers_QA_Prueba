# Casos de prueba funcionales — MakersPay

## Objetivo

Documentar casos de prueba detallados para validar la funcionalidad de envío de dinero entre usuarios registrados de MakersPay.

## Consideración general

MakersPay es un producto ficticio y no se proporcionó un ambiente ejecutable. Por este motivo, los casos se encuentran diseñados para una futura ejecución.

---

## CP-001 — Transferencia exitosa con monto válido

**Escenario relacionado:** EF-001
**Prioridad:** Crítica
**Tipo de prueba:** Funcional, positivo, end-to-end
**Técnica:** Partición de equivalencia
**Estado:** No ejecutado — producto ficticio sin ambiente disponible

### Precondiciones

* El usuario remitente está autenticado.
* El remitente tiene un saldo disponible de $500.000 COP.
* El destinatario está registrado.
* El celular del destinatario es diferente al del remitente.

### Datos de prueba

* Celular del remitente: `3009999999`
* Celular del destinatario: `3001234567`
* Saldo inicial del remitente: `$500.000 COP`
* Saldo inicial del destinatario: `$100.000 COP`
* Monto: `$50.000 COP`

### Pasos

1. Ingresar a la opción **Enviar dinero**.
2. Ingresar el celular `3001234567`.
3. Ingresar el monto `$50.000 COP`.
4. Presionar el botón **Enviar**.
5. Confirmar la operación.
6. Consultar el saldo del remitente.
7. Consultar el saldo del destinatario.
8. Consultar el historial de ambos usuarios.

### Resultado esperado

* La transferencia se procesa exitosamente.
* El saldo del remitente queda en `$450.000 COP`.
* El saldo del destinatario queda en `$150.000 COP`.
* Se registra un débito en el historial del remitente.
* Se registra un crédito en el historial del destinatario.
* Ambos movimientos poseen la misma referencia.
* Se muestra un mensaje o comprobante de éxito.

---

## CP-002 — Transferencia por el monto mínimo permitido

**Escenario relacionado:** EF-002
**Prioridad:** Alta
**Tipo de prueba:** Funcional, positivo
**Técnica:** Análisis de valores límite
**Estado:** No ejecutado — producto ficticio sin ambiente disponible

### Precondiciones

* El usuario está autenticado.
* El destinatario está registrado.
* El remitente posee saldo suficiente.

### Datos de prueba

* Celular del destinatario: `3001234567`
* Monto: `$5.000 COP`

### Pasos

1. Ingresar a **Enviar dinero**.
2. Ingresar el celular del destinatario.
3. Ingresar `$5.000 COP`.
4. Confirmar la transferencia.

### Resultado esperado

* La transferencia es aceptada.
* El monto se descuenta correctamente del remitente.
* El monto se acredita correctamente al destinatario.
* La operación se registra en ambos historiales.

---

## CP-003 — Transferencia por el monto máximo permitido

**Escenario relacionado:** EF-003
**Prioridad:** Alta
**Tipo de prueba:** Funcional, positivo
**Técnica:** Análisis de valores límite
**Estado:** No ejecutado — producto ficticio sin ambiente disponible

### Precondiciones

* El usuario está autenticado.
* El destinatario está registrado.
* El remitente posee al menos `$2.000.000 COP`.

### Datos de prueba

* Celular del destinatario: `3001234567`
* Monto: `$2.000.000 COP`

### Pasos

1. Ingresar a **Enviar dinero**.
2. Completar el celular del destinatario.
3. Ingresar `$2.000.000 COP`.
4. Confirmar la operación.

### Resultado esperado

* La transferencia es procesada correctamente.
* Los saldos se actualizan.
* El movimiento se registra en ambos historiales.
* No se muestra ningún mensaje de validación por límite máximo.

---

## CP-004 — Transferencia por debajo del monto mínimo

**Escenario relacionado:** EF-004
**Prioridad:** Alta
**Tipo de prueba:** Funcional, negativo
**Técnica:** Análisis de valores límite
**Estado:** No ejecutado — producto ficticio sin ambiente disponible

### Precondiciones

* Usuario autenticado.
* Destinatario registrado.

### Datos de prueba

* Celular del destinatario: `3001234567`
* Monto: `$4.999 COP`

### Pasos

1. Ingresar a **Enviar dinero**.
2. Ingresar el celular del destinatario.
3. Ingresar `$4.999 COP`.
4. Confirmar la transferencia.

### Resultado esperado

* La transferencia es rechazada.
* Se muestra un mensaje indicando que el mínimo permitido es `$5.000 COP`.
* El saldo del remitente no cambia.
* El saldo del destinatario no cambia.
* No se registra una transferencia exitosa.

---

## CP-005 — Transferencia por encima del monto máximo

**Escenario relacionado:** EF-005
**Prioridad:** Alta
**Tipo de prueba:** Funcional, negativo
**Técnica:** Análisis de valores límite
**Estado:** No ejecutado — producto ficticio sin ambiente disponible

### Precondiciones

* Usuario autenticado.
* Destinatario registrado.
* Remitente con saldo suficiente.

### Datos de prueba

* Celular del destinatario: `3001234567`
* Monto: `$2.000.001 COP`

### Pasos

1. Ingresar a **Enviar dinero**.
2. Ingresar el celular del destinatario.
3. Ingresar `$2.000.001 COP`.
4. Confirmar la transferencia.

### Resultado esperado

* La transferencia es rechazada.
* Se informa que el monto máximo permitido es `$2.000.000 COP`.
* Los saldos no se modifican.
* No se registra una operación exitosa.

---

## CP-006 — Transferencia superior al saldo disponible

**Escenario relacionado:** EF-006
**Prioridad:** Crítica
**Tipo de prueba:** Funcional, negativo
**Técnica:** Partición de equivalencia
**Estado:** No ejecutado — producto ficticio sin ambiente disponible

### Precondiciones

* Usuario autenticado.
* Destinatario registrado.
* El remitente posee `$100.000 COP`.

### Datos de prueba

* Celular del destinatario: `3001234567`
* Monto: `$150.000 COP`

### Pasos

1. Ingresar a **Enviar dinero**.
2. Completar el celular del destinatario.
3. Ingresar `$150.000 COP`.
4. Confirmar la transferencia.

### Resultado esperado

* La transferencia es rechazada.
* Se muestra un mensaje de saldo insuficiente.
* El saldo del remitente permanece en `$100.000 COP`.
* El saldo del destinatario no cambia.
* No se registra una transferencia exitosa.

---

## CP-007 — Transferencia utilizando el saldo exacto

**Escenario relacionado:** EF-007
**Prioridad:** Alta
**Tipo de prueba:** Funcional, positivo
**Técnica:** Análisis de valores límite
**Estado:** No ejecutado — producto ficticio sin ambiente disponible

### Precondiciones

* Usuario autenticado.
* Destinatario registrado.
* Saldo del remitente: `$50.000 COP`.

### Datos de prueba

* Celular del destinatario: `3001234567`
* Monto: `$50.000 COP`

### Pasos

1. Ingresar a **Enviar dinero**.
2. Completar el celular.
3. Ingresar `$50.000 COP`.
4. Confirmar.

### Resultado esperado

* La transferencia es exitosa.
* El saldo final del remitente queda en `$0 COP`.
* El destinatario recibe `$50.000 COP`.
* Se registran ambos movimientos.

---

## CP-008 — Transferencia al mismo número del remitente

**Escenario relacionado:** EF-008
**Prioridad:** Alta
**Tipo de prueba:** Funcional, negativo
**Técnica:** Tabla de decisión
**Estado:** No ejecutado — producto ficticio sin ambiente disponible

### Precondiciones

* Usuario autenticado.
* Celular del remitente: `3009999999`.

### Datos de prueba

* Celular del destinatario: `3009999999`
* Monto: `$50.000 COP`

### Pasos

1. Ingresar a **Enviar dinero**.
2. Ingresar el mismo celular del remitente.
3. Ingresar un monto válido.
4. Confirmar.

### Resultado esperado

* La transferencia es rechazada.
* Se muestra un mensaje claro indicando que no se puede transferir al mismo número.
* El saldo no se modifica.
* No se registra ningún movimiento exitoso.

---

## CP-009 — Transferencia a usuario no registrado

**Escenario relacionado:** EF-009
**Prioridad:** Alta
**Tipo de prueba:** Funcional, negativo
**Técnica:** Partición de equivalencia
**Estado:** No ejecutado — producto ficticio sin ambiente disponible

### Precondiciones

* Usuario autenticado.
* El número `3110000000` no pertenece a un usuario registrado.

### Datos de prueba

* Celular del destinatario: `3110000000`
* Monto: `$50.000 COP`

### Pasos

1. Ingresar a **Enviar dinero**.
2. Ingresar el número no registrado.
3. Ingresar un monto válido.
4. Confirmar.

### Resultado esperado

* La transferencia es rechazada.
* Se muestra un mensaje informando que el destinatario no está registrado.
* Los saldos no se modifican.
* No se registra una transferencia exitosa.

---

## CP-010 — Validación de celular obligatorio

**Escenario relacionado:** EF-010
**Prioridad:** Media
**Tipo de prueba:** Funcional, negativo
**Técnica:** Partición de equivalencia
**Estado:** No ejecutado — producto ficticio sin ambiente disponible

### Precondiciones

* Usuario autenticado.

### Datos de prueba

* Celular: vacío
* Monto: `$50.000 COP`

### Pasos

1. Ingresar a **Enviar dinero**.
2. Dejar el celular vacío.
3. Ingresar `$50.000 COP`.
4. Confirmar.

### Resultado esperado

* La operación no se procesa.
* Se informa que el celular es obligatorio.
* El saldo no se modifica.

---

## CP-011 — Validación de monto obligatorio

**Escenario relacionado:** EF-011
**Prioridad:** Media
**Tipo de prueba:** Funcional, negativo
**Técnica:** Partición de equivalencia
**Estado:** No ejecutado — producto ficticio sin ambiente disponible

### Precondiciones

* Usuario autenticado.
* Destinatario registrado.

### Datos de prueba

* Celular: `3001234567`
* Monto: vacío

### Pasos

1. Ingresar a **Enviar dinero**.
2. Completar el celular.
3. Dejar el monto vacío.
4. Confirmar.

### Resultado esperado

* La operación no se procesa.
* Se informa que el monto es obligatorio.
* Los saldos no se modifican.

---

## CP-012 — Doble clic en el botón Enviar

**Escenario relacionado:** EF-015
**Prioridad:** Crítica
**Tipo de prueba:** Concurrencia, integridad
**Técnica:** Error guessing
**Estado:** No ejecutado — producto ficticio sin ambiente disponible

### Precondiciones

* Usuario autenticado.
* Destinatario registrado.
* Saldo suficiente.

### Datos de prueba

* Celular del destinatario: `3001234567`
* Monto: `$50.000 COP`

### Pasos

1. Completar una transferencia válida.
2. Presionar dos veces rápidamente el botón **Enviar**.
3. Consultar el saldo del remitente.
4. Consultar el saldo del destinatario.
5. Consultar ambos historiales.

### Resultado esperado

* Se procesa una única transferencia.
* Se realiza un único débito.
* Se realiza una única acreditación.
* Existe un único registro en cada historial.
* La operación posee una única referencia.

---

## CP-013 — Timeout durante el procesamiento

**Escenario relacionado:** EF-016
**Prioridad:** Crítica
**Tipo de prueba:** Integración, resiliencia
**Técnica:** Error guessing
**Estado:** No ejecutado — producto ficticio sin ambiente disponible

### Precondiciones

* Usuario autenticado.
* Destinatario registrado.
* Saldo suficiente.

### Pasos

1. Completar una transferencia válida.
2. Confirmar la operación.
3. Simular un timeout durante el procesamiento.
4. Reintentar la operación.
5. Consultar saldos e historiales.

### Resultado esperado

* El sistema informa claramente el estado de la operación.
* No se genera una transferencia duplicada.
* Los saldos permanecen consistentes.
* El reintento no produce un segundo débito.
* La operación puede rastrearse mediante una referencia.

---

## CP-014 — Transferencia fallida sin modificación de saldos

**Escenario relacionado:** EF-021
**Prioridad:** Crítica
**Tipo de prueba:** Integración, negativo, integridad
**Técnica:** Pruebas basadas en riesgos
**Estado:** No ejecutado — producto ficticio sin ambiente disponible

### Precondiciones

* Usuario autenticado.
* Destinatario registrado.
* Saldo suficiente.

### Pasos

1. Iniciar una transferencia válida.
2. Simular una falla durante el procesamiento.
3. Consultar el saldo del remitente.
4. Consultar el saldo del destinatario.
5. Consultar ambos historiales.

### Resultado esperado

* Se muestra un mensaje de error claro.
* El saldo del remitente no cambia.
* El saldo del destinatario no cambia.
* No se registra una transferencia exitosa.
* El sistema no queda en un estado parcial.

---

## CP-015 — Usuario no autenticado intenta transferir

**Escenario relacionado:** EF-022
**Prioridad:** Crítica
**Tipo de prueba:** Seguridad, negativo
**Técnica:** Tabla de decisión
**Estado:** No ejecutado — producto ficticio sin ambiente disponible

### Precondiciones

* El usuario no posee una sesión activa.

### Pasos

1. Intentar acceder a la opción **Enviar dinero**.
2. Intentar ingresar datos de transferencia.
3. Intentar confirmar la operación.

### Resultado esperado

* El sistema impide el acceso.
* Se solicita autenticación.
* No se procesa ninguna transferencia.
* No se exponen saldos ni información de otros usuarios.

---

## Resumen de cobertura

| Regla o riesgo         | Casos relacionados | Escenario Gherkin       |
| ---------------------- | ------------------ | ----------------------- |
| Transferencia exitosa  | CP-001             | EF-001                  |
| Monto mínimo           | CP-002, CP-004     | EF-002/003, EF-004/005  |
| Monto máximo           | CP-003, CP-005     | EF-002/003, EF-004/005  |
| Saldo disponible       | CP-006, CP-007     | EF-006, EF-007          |
| Mismo número           | CP-008             | EF-008                  |
| Usuario no registrado  | CP-009             | EF-009                  |
| Campos obligatorios    | CP-010, CP-011     | EF-010/014              |
| Doble transferencia    | CP-012             | EF-015                  |
| Timeout                | CP-013             | EF-016                  |
| Falla sin cambios      | CP-014             | EF-021                  |
| Usuario no autenticado | CP-015             | EF-022                  |

> Escenarios Gherkin definidos en `docs/testScenarios/money-transfer.feature`
