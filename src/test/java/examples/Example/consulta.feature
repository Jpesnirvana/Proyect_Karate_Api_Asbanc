Feature: sample karate test script
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  Background:
    * url 'https://api-test1.utec.net.pe'
    * header Content-Type = 'application/json'
    #* def expectedOutput = read('../response/result1.json')

  Scenario Outline: get debt
    Given path '/finance-api/v1/asbanc/debts/query'
    And request { "product":"<product>","queryType":<queryType>, "queryPayload": "73145859", "bank": <bank>,"channel": 14,"business": "636" }
    When method POST
    #ordena el response
    Then print 'response---',response
    Then status 200
    And match response contains {"message": "success"}
    And match response.content contains {"asbancStatus" : "0"}
    And match response.content contains {"asbancMessage" : "TRANSACCION PROCESADA OK"}

    #para definir y obtener una variable
    * def Cliente = response.content.client
    Then print Cliente
    And assert response.content.client == Cliente


    #otra forma de hacer el "contains"
    And match response.message contains "success"
    #si quiero q me muestre un error tendria q nomrarlo de la sigt manera
    And match response.message !contains "succss"
    # de lo contrario dara un falso positivo
    And match response.message contains "succe"
    #para leer un csv
    Examples:
      |read('../response/Data.csv')|

    #And match response == expectedOutput
    #* def foo = {product:'001'}
    #* match foo == {product:'001'}

#--------------------------------------------------------------------
#    Scenario: get all users and then get the first user by id
#    Given path 'users'
#    When method get
#    Then status 200
#
#    * def first = response[0]
#
#    Given path 'users', first.id
#    When method get
#    Then status 200
#
#  Scenario: create a user and then get it by id
#    * def user =
#      """
#      {
#        "name": "Test User",
#        "username": "testuser",
#        "email": "test@user.com",
#        "address": {
#          "street": "Has No Name",
#          "suite": "Apt. 123",
#          "city": "Electri",
#          "zipcode": "54321-6789"
#        }
#      }
#      """


#    * def id = response.id
#    * print 'created id is: ', id
#
#    Given path id
    # When method get
    # Then status 200
    # And match response contains user
