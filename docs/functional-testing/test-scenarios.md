# Escenarios de prueba — Envío de dinero

## Objetivo

Documentar los escenarios funcionales, negativos, de integración, seguridad y concurrencia asociados a la funcionalidad de envío de dinero de MakersPay.

## Alcance

Un usuario autenticado puede enviar dinero a otro usuario registrado utilizando su número de celular.

## Reglas de negocio consideradas

- El monto mínimo por transacción es de $5.000 COP.
- El monto máximo por transacción es de $2.000.000 COP.
- El usuario no puede enviar más dinero que el saldo disponible.
- No se permiten transferencias al mismo número de celular.
- En una transacción exitosa se actualizan ambos saldos y ambos historiales.
- En una transacción fallida no deben modificarse los saldos.

## Escenarios

| ID | Escenario | Tipo | Prioridad |
|---|---|---|---|
| EF-001 | Transferencia exitosa con monto válido | Positivo / E2E | Crítica |
| EF-002 | Transferencia por $5.000 COP | Valor límite | Alta |
| EF-003 | Transferencia por $2.000.000 COP | Valor límite | Alta |
| EF-004 | Transferencia por $4.999 COP | Negativo / Límite | Alta |
| EF-005 | Transferencia por $2.000.001 COP | Negativo / Límite | Alta |
| EF-006 | Transferencia superior al saldo disponible | Negativo | Crítica |
| EF-007 | Transferencia utilizando el saldo exacto | Positivo | Alta |
| EF-008 | Transferencia al mismo número de celular | Negativo | Alta |
| EF-009 | Transferencia a un usuario no registrado | Negativo | Alta |
| EF-010 | Celular vacío | Negativo | Media |
| EF-011 | Monto vacío | Negativo | Media |
| EF-012 | Monto igual a cero | Negativo | Alta |
| EF-013 | Monto negativo | Negativo | Alta |
| EF-014 | Monto con caracteres alfabéticos | Negativo | Media |
| EF-015 | Doble clic en el botón Enviar | Concurrencia | Crítica |
| EF-016 | Timeout durante la transferencia | Integración | Crítica |
| EF-017 | Actualización del saldo del remitente | Integración | Crítica |
| EF-018 | Actualización del saldo del destinatario | Integración | Crítica |
| EF-019 | Registro en el historial del remitente | Integración | Alta |
| EF-020 | Registro en el historial del destinatario | Integración | Alta |
| EF-021 | Transferencia fallida sin modificar saldos | Negativo / Integridad | Crítica |
| EF-022 | Usuario no autenticado intenta transferir | Seguridad | Crítica |

## Técnicas de prueba aplicadas

- Partición de equivalencia.
- Análisis de valores límite.
- Tabla de decisión.
- Transición de estados.
- Error guessing.
- Pruebas basadas en riesgos.

## Consideraciones

Estos escenarios fueron diseñados a partir del requerimiento funcional proporcionado. Debido a que MakersPay es un producto ficticio sin ambiente ejecutable, los escenarios quedan documentados para una futura ejecución.
