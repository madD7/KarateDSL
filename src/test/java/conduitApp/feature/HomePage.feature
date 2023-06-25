
# Each feature file always starts with the keyword - Feature: <Description>
Feature: Test for Home page
# Each test in Karate is a scenario
Scenario: Get all Tags
    # To make successful request, we need: API url, Method type & Header
    # Karate will, by default, make header.
    Given url 'https://conduit.productionready.io/api/tags'
    ###  Given url 'https://demo.productionready.io/api/tags'  # One of the two url must work. Currently, both are not working.
    When method Get
    Then status 200
# End of Scenario

Scenario: Get 10 articles from the page passing individual parameter 
    # Request with two parameters. Parameter passing in url is not good idea.
    ### Given url 'https://conduit.productionready.io/api/articles?limit=10&offset=0'

    Given param limit=10
    Given param offset=0
    Given url 'https://conduit.productionready.io/api/articles'
    When method Get
    Then status 200
# End of Scenario

Scenario: Get 10 articles from the page passing object with parameters
    
    Given params { limit:10, offset:0 }
    Given url 'https://conduit.productionready.io/api/articles'
    When method Get
    Then status 200
# End of Scenario

    