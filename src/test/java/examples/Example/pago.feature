Feature: sample karate test script
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  Background:
    * url 'https://api-test1.utec.net.pe'
    * header Content-Type = 'application/json'
    * def feature = read('consulta.feature')
    * def result = call feature

  Scenario: Payment Operation Register
    * def product = result.response.content.debts[0].product
    * def number = result.response.content.debts[0].document.number
    * def amount = result.response.content.debts[0].amount
    Then print amount
    Given path '/finance-api/v1/asbanc/payments/register'
    And request {"product": "#(product)","queryType": 1,"queryPayload": "73145859","bank": 1020,"channel": 10,"business": "636","amount": "303.36","document": "#(number)","currency": "1","date": "21052020","time": "120101","operation": "J1","type": "01"}
    Then print 'response---',response
    When method POST
    Then status 200
    And match response contains {"message": "success"}
    And match response.content contains {"asbancStatus" : "0"}
    And match response.content contains {"asbancMessage" : "TRANSACCION PROCESADA OK"}
    * def Cliente = result.response.content.client
    And assert result.response.content.client == Cliente
    Then print Cliente

