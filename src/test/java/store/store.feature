Feature: API Store Testing

  Background:
    * url baseUrl
    * def orderPayload =
      """
      {
        "id": 0,
        "petId": 0,
        "quantity": 0,
        "status": "placed",
        "complete": true
      }
      """


  Scenario: Obtener una orden existente
    Given path '/store/order/2'
    When method GET
    Then status 200
    And match response.id == 2
    And match response.status == "placed"

  Scenario: Obtener una orden inexistente (debe devolver 400)
    Given path '/store/order/0'
    When method GET
    Then status 404
    And match response.message == "Order not found"

  Scenario: Crear una nueva orden
    Given path '/store/order'
    And request orderPayload
    When method POST
    Then status 200

  Scenario: Crear una orden con datos inválidos (debe devolver 400)
    * def errorOrderPayload =
      """
      {
        "id": abc,
        "petId": 0,
        "quantity": 0,
        "status": "placed",
        "complete": true
      }
      """
    Given path '/store/order'
    And request errorOrderPayload
    When method POST
    Then status 400

  Scenario: Eliminar una orden existente
    Given path '/store/order/999'
    When method DELETE
    Then status 200

  Scenario: Intentar eliminar una orden inexistente (debe devolver 400)
    Given path '/store/order/999999'
    When method DELETE
    Then status 400

  Scenario: Validar respuesta de error 500 en creación de orden
    Given path '/store/order'
    And request {}
    When method POST
    Then status 500
