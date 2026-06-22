# Reportes de defectos hipotéticos — MakersPay

## Objetivo

Documentar ejemplos de defectos relevantes que podrían detectarse durante la ejecución de pruebas sobre la funcionalidad de envío de dinero de MakersPay.

> **Aclaración:** MakersPay es un producto ficticio y no se proporcionó un ambiente ejecutable. Por este motivo, los defectos incluidos en este documento son hipotéticos y tienen como objetivo demostrar el proceso de reporte, priorización y análisis de impacto.

---

# BUG-001 — Se generan dos transferencias al presionar dos veces el botón Enviar

**Estado:** Hipotético
**Módulo:** Envío de dinero
**Severidad:** Crítica
**Prioridad:** Alta
**Tipo:** Funcional / Concurrencia / Integridad
**Caso relacionado:** CP-012
**Escenario relacionado:** EF-015

## Descripción

Al presionar dos veces rápidamente el botón **Enviar**, el sistema procesa dos transferencias independientes en lugar de una sola.

## Precondiciones

* El usuario remitente está autenticado.
* El remitente posee saldo suficiente.
* El destinatario está registrado.
* El remitente tiene un saldo inicial de `$500.000 COP`.

## Datos de prueba

* Celular destinatario: `3001234567`
* Monto: `$50.000 COP`

## Pasos para reproducir

1. Ingresar a la opción **Enviar dinero**.
2. Completar el celular del destinatario.
3. Ingresar el monto de `$50.000 COP`.
4. Presionar dos veces rápidamente el botón **Enviar**.
5. Consultar el saldo del remitente.
6. Consultar el saldo del destinatario.
7. Revisar el historial de ambos usuarios.

## Resultado actual hipotético

* Se generan dos transferencias.
* Se descuentan `$100.000 COP` del remitente.
* Se acreditan `$100.000 COP` al destinatario.
* Se registran dos movimientos en los historiales.

## Resultado esperado

* Debe procesarse una única transferencia.
* Debe realizarse un único débito de `$50.000 COP`.
* Debe realizarse una única acreditación de `$50.000 COP`.
* Debe registrarse un único movimiento en cada historial.
* El botón debe bloquearse o el backend debe controlar la idempotencia.

## Impacto de negocio

Este defecto puede generar pérdida de dinero, reclamos de clientes, inconsistencias contables y necesidad de reversión manual.

## Evidencia esperada

* Video de la ejecución.
* Captura del saldo antes y después.
* Identificadores de ambas transacciones.
* Registro de historial.
* Request y response de la API.
* Logs asociados a la operación.

---

# BUG-002 — Se descuenta el saldo del remitente, pero no se acredita al destinatario

**Estado:** Hipotético
**Módulo:** Envío de dinero
**Severidad:** Crítica
**Prioridad:** Alta
**Tipo:** Integración / Integridad de datos
**Caso relacionado:** CP-001, CP-014
**Escenario relacionado:** EF-017, EF-018, EF-021

## Descripción

La operación informa que la transferencia fue procesada, el saldo del remitente disminuye, pero el saldo del destinatario no se incrementa.

## Precondiciones

* El remitente está autenticado.
* El destinatario está registrado.
* El remitente tiene saldo suficiente.

## Datos de prueba

* Saldo inicial remitente: `$500.000 COP`
* Saldo inicial destinatario: `$100.000 COP`
* Monto: `$50.000 COP`

## Pasos para reproducir

1. Ingresar a **Enviar dinero**.
2. Ingresar el celular del destinatario.
3. Ingresar `$50.000 COP`.
4. Confirmar la transferencia.
5. Consultar el saldo del remitente.
6. Consultar el saldo del destinatario.
7. Revisar los historiales.

## Resultado actual hipotético

* El saldo del remitente queda en `$450.000 COP`.
* El saldo del destinatario permanece en `$100.000 COP`.
* La interfaz puede mostrar un mensaje de éxito.

## Resultado esperado

* El saldo del remitente debe quedar en `$450.000 COP`.
* El saldo del destinatario debe quedar en `$150.000 COP`.
* Ambos historiales deben registrar la operación.
* La transferencia no debe quedar en estado parcial.

## Impacto de negocio

El dinero queda descontado sin llegar al destinatario, lo que produce una inconsistencia financiera crítica y pérdida de confianza del usuario.

## Evidencia esperada

* Captura de ambos saldos.
* Identificador de la transacción.
* Registro de base de datos.
* Request y response.
* Logs del servicio de transferencias.
* Estado del movimiento en ambos historiales.

---

# BUG-003 — La transferencia exitosa no se registra en el historial del destinatario

**Estado:** Hipotético
**Módulo:** Historial de movimientos
**Severidad:** Alta
**Prioridad:** Alta
**Tipo:** Funcional / Integración / Trazabilidad
**Caso relacionado:** CP-001
**Escenario relacionado:** EF-019, EF-020

## Descripción

La transferencia actualiza correctamente ambos saldos, pero el movimiento no aparece en el historial del destinatario.

## Precondiciones

* El remitente está autenticado.
* El destinatario está registrado.
* El remitente posee saldo suficiente.

## Datos de prueba

* Celular destinatario: `3001234567`
* Monto: `$50.000 COP`

## Pasos para reproducir

1. Realizar una transferencia válida.
2. Confirmar el mensaje de éxito.
3. Consultar el saldo del remitente.
4. Consultar el saldo del destinatario.
5. Ingresar al historial del remitente.
6. Ingresar al historial del destinatario.

## Resultado actual hipotético

* El saldo del remitente disminuye correctamente.
* El saldo del destinatario aumenta correctamente.
* El movimiento aparece en el historial del remitente.
* El movimiento no aparece en el historial del destinatario.

## Resultado esperado

* El movimiento debe aparecer en ambos historiales.
* Ambos registros deben compartir la misma referencia.
* Deben mostrarse monto, fecha, hora, estado y contraparte.

## Impacto de negocio

La falta de trazabilidad puede generar reclamos, problemas de conciliación y dificultad para auditar la operación.

## Evidencia esperada

* Captura de ambos historiales.
* Captura de saldos.
* Identificador de la transferencia.
* Logs del servicio de movimientos.
* Registro correspondiente en base de datos.

---

# BUG-004 — El sistema permite transferir un monto inferior al mínimo permitido

**Estado:** Hipotético
**Módulo:** Envío de dinero
**Severidad:** Alta
**Prioridad:** Alta
**Tipo:** Funcional / Regla de negocio
**Caso relacionado:** CP-004
**Escenario relacionado:** EF-004

## Descripción

El sistema permite procesar una transferencia por `$4.999 COP`, aunque el monto mínimo permitido es de `$5.000 COP`.

## Precondiciones

* El usuario está autenticado.
* El destinatario está registrado.
* El remitente tiene saldo suficiente.

## Datos de prueba

* Celular destinatario: `3001234567`
* Monto: `$4.999 COP`

## Pasos para reproducir

1. Ingresar a **Enviar dinero**.
2. Ingresar el celular del destinatario.
3. Ingresar `$4.999 COP`.
4. Confirmar la transferencia.
5. Revisar saldos e historiales.

## Resultado actual hipotético

* La transferencia es procesada.
* Los saldos se modifican.
* El movimiento se registra.

## Resultado esperado

* La transferencia debe ser rechazada.
* Debe mostrarse un mensaje claro indicando que el mínimo es `$5.000 COP`.
* Los saldos no deben modificarse.
* No debe registrarse una operación exitosa.

## Impacto de negocio

El sistema incumple una regla de negocio explícita y permite operaciones fuera de los límites definidos.

## Evidencia esperada

* Captura del monto ingresado.
* Captura del mensaje de éxito.
* Captura de saldos.
* Registro de historial.
* Request y response.

---

# BUG-005 — Una transferencia fallida modifica el saldo del remitente

**Estado:** Hipotético
**Módulo:** Envío de dinero
**Severidad:** Crítica
**Prioridad:** Alta
**Tipo:** Integridad / Manejo de errores
**Caso relacionado:** CP-014
**Escenario relacionado:** EF-021

## Descripción

Cuando ocurre una falla durante el procesamiento, el sistema muestra un mensaje de error, pero el saldo del remitente igualmente disminuye.

## Precondiciones

* Usuario autenticado.
* Destinatario registrado.
* Remitente con saldo suficiente.

## Datos de prueba

* Saldo inicial remitente: `$500.000 COP`
* Monto: `$50.000 COP`

## Pasos para reproducir

1. Iniciar una transferencia válida.
2. Simular una falla durante el procesamiento.
3. Verificar el mensaje mostrado.
4. Consultar el saldo del remitente.
5. Consultar el saldo del destinatario.
6. Revisar ambos historiales.

## Resultado actual hipotético

* Se muestra un mensaje de error.
* El saldo del remitente queda en `$450.000 COP`.
* El destinatario no recibe el dinero.
* La operación puede no aparecer en el historial.

## Resultado esperado

* La transferencia debe quedar rechazada o fallida.
* El saldo del remitente debe permanecer en `$500.000 COP`.
* El saldo del destinatario no debe modificarse.
* No debe registrarse una transferencia exitosa.
* Si hubo un débito parcial, debe ejecutarse una reversión automática.

## Impacto de negocio

El usuario pierde dinero a pesar de que la operación fue informada como fallida. Es un defecto crítico con impacto financiero directo.

## Evidencia esperada

* Captura del mensaje de error.
* Captura de saldo antes y después.
* Request y response.
* Logs.
* Identificador de correlación.
* Registro de reversión, si existe.

---

## Resumen de defectos hipotéticos

| ID      | Defecto                                    | Severidad | Prioridad |
| ------- | ------------------------------------------ | --------- | --------- |
| BUG-001 | Doble transferencia por doble clic         | Crítica   | Alta      |
| BUG-002 | Débito sin acreditación al destinatario    | Crítica   | Alta      |
| BUG-003 | Historial faltante del destinatario        | Alta      | Alta      |
| BUG-004 | Transferencia inferior al mínimo permitido | Alta      | Alta      |
| BUG-005 | Transferencia fallida modifica el saldo    | Crítica   | Alta      |
