Feature: Envío de dinero entre usuarios de MakersPay

  Como usuario autenticado de MakersPay
  Quiero enviar dinero a otro usuario registrado mediante su número de celular
  Para transferir fondos de forma segura

  Background:
    Given el usuario remitente está autenticado
    And el usuario remitente tiene un saldo disponible de 3000000 COP
    And existe un usuario destinatario registrado con el celular "3001234567"
    And el celular del remitente es "3009999999"

  @positivo @e2e @critico @smoke @regresion
  Scenario: EF-001 Transferencia exitosa con monto válido
    When el remitente envía 50000 COP al celular "3001234567"
    Then la transferencia debe procesarse exitosamente
    And el saldo del remitente debe disminuir en 50000 COP
    And el saldo del destinatario debe aumentar en 50000 COP
    And el movimiento debe registrarse en el historial de ambos usuarios

  @limite @alta @regresion
  Scenario Outline: EF-002/003 Transferencia con montos válidos en los límites
    When el remitente envía <monto> COP al celular "3001234567"
    Then la transferencia debe procesarse exitosamente
    And los saldos deben actualizarse correctamente

    Examples:
      | monto   |
      | 5000    |
      | 2000000 |

  @negativo @limite @alta @regresion
  Scenario Outline: EF-004/005 Rechazo de montos fuera de los límites
    When el remitente intenta enviar <monto> COP al celular "3001234567"
    Then la transferencia debe ser rechazada
    And debe mostrarse el mensaje "<mensaje>"
    And los saldos no deben modificarse

    Examples:
      | monto   | mensaje                                  |
      | 4999    | El monto mínimo permitido es 5000 COP    |
      | 2000001 | El monto máximo permitido es 2000000 COP |

  @negativo @critico @regresion
  Scenario: EF-006 Transferencia superior al saldo disponible
    Given el saldo disponible del remitente es 100000 COP
    When el remitente intenta enviar 150000 COP al celular "3001234567"
    Then la transferencia debe ser rechazada
    And debe mostrarse el mensaje "Saldo insuficiente"
    And los saldos no deben modificarse

  @positivo @alta
  Scenario: EF-007 Transferencia utilizando el saldo exacto
    Given el saldo disponible del remitente es 50000 COP
    When el remitente envía 50000 COP al celular "3001234567"
    Then la transferencia debe procesarse exitosamente
    And el saldo del remitente debe quedar en 0 COP
    And el movimiento debe registrarse en el historial de ambos usuarios

  @negativo @alta @regresion
  Scenario: EF-008 Transferencia al mismo número de celular
    When el remitente intenta enviar 50000 COP al celular "3009999999"
    Then la transferencia debe ser rechazada
    And debe mostrarse el mensaje "No puedes enviar dinero a tu propio número de celular"
    And el saldo del remitente no debe modificarse

  @negativo @alta @regresion
  Scenario: EF-009 Transferencia a un usuario no registrado
    When el remitente intenta enviar 50000 COP al celular "3110000000"
    Then la transferencia debe ser rechazada
    And debe mostrarse el mensaje "El número ingresado no pertenece a un usuario registrado"
    And el saldo del remitente no debe modificarse

  @negativo @validacion
  Scenario Outline: EF-010/014 Validación de datos obligatorios e inválidos
    When el remitente completa el celular con "<celular>"
    And completa el monto con "<monto>"
    And confirma la transferencia
    Then la transferencia debe ser rechazada
    And debe mostrarse el mensaje "<mensaje>"
    And el saldo del remitente no debe modificarse

    Examples:
      | celular    | monto | mensaje                        |
      |            | 50000 | El celular es obligatorio      |
      | 3001234567 |       | El monto es obligatorio        |
      | 3001234567 | 0     | El monto debe ser mayor a cero |
      | 3001234567 | -5000 | El monto debe ser mayor a cero |
      | 3001234567 | ABC   | El monto debe ser numérico     |

  @concurrencia @critico
  Scenario: EF-015 Doble clic en el botón Enviar
    When el remitente completa una transferencia válida por 50000 COP
    And presiona dos veces el botón Enviar
    Then debe registrarse una única transferencia
    And debe realizarse un único débito
    And debe realizarse una única acreditación

  @integracion @critico
  Scenario: EF-016 Timeout durante la transferencia
    When el remitente confirma una transferencia válida
    And ocurre un timeout durante el procesamiento
    Then debe mostrarse un mensaje claro sobre el estado de la operación
    And no debe generarse una transferencia duplicada al reintentar
    And los saldos deben permanecer consistentes

  @integracion @critico
  Scenario Outline: EF-017/018 Actualización de saldos post-transferencia
    Given el saldo inicial del remitente es 500000 COP
    And el saldo inicial del destinatario es 100000 COP
    When el remitente envía 50000 COP al celular "3001234567"
    Then el saldo final del <usuario> debe ser <saldo_final> COP

    Examples:
      | usuario      | saldo_final |
      | remitente    | 450000      |
      | destinatario | 150000      |

  @integracion @alta
  Scenario Outline: EF-019/020 Registro en historial del remitente y destinatario
    When el remitente envía 50000 COP al celular "3001234567"
    Then el historial del <usuario> debe registrar un <tipo_movimiento> de 50000 COP
    And el movimiento debe incluir <contraparte>, fecha, hora, estado y referencia

    Examples:
      | usuario      | tipo_movimiento | contraparte  |
      | remitente    | débito          | destinatario |
      | destinatario | crédito         | remitente    |

  @negativo @integridad @critico
  Scenario: EF-021 Transferencia fallida sin modificación de saldos
    When el remitente intenta realizar una transferencia
    And la transferencia falla durante el procesamiento
    Then debe mostrarse un mensaje de error claro
    And los saldos no deben modificarse
    And no debe registrarse una transferencia exitosa

  @seguridad @critico
  Scenario: EF-022 Usuario no autenticado intenta transferir
    Given el usuario no tiene una sesión activa
    When intenta acceder a la funcionalidad de envío de dinero
    Then el sistema debe impedir el acceso
    And debe solicitar autenticación
    And no debe procesarse ninguna transferencia
