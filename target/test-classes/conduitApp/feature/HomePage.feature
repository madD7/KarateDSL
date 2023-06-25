
# Each feature file always starts with the keyword - Feature: <Description>
Feature: Test for Home page

    # The Background keyword is applied to replicate the same steps before all Scenarios within a Feature File
    Background: Define URL 
        Given url 'https://conduit.productionready.io/api/' 

    # Each test in Karate is a scenario
    Scenario: Get all Tags
        # To make successful request, we need: API url, Method type & Header
        # Karate will, by default, make header.

        ###  Given url 'https://demo.productionready.io/api/tags'  # One of the two url must work. Currently, both are not working.
        Given path 'tags'
        When method Get
        Then status 200
    # End of Scenario

    Scenario: Get 10 articles from the page passing individual parameter 
        # Request with two parameters. Parameter passing in url is not good idea.
        ### Given url 'https://conduit.productionready.io/api/articles?limit=10&offset=0'

        Given param limit=10
        Given param offset=0
        Given path 'articles'
        When method Get
        Then status 200
    # End of Scenario

    Scenario: Get 10 articles from the page passing object with parameters
        Given params { limit:10, offset:0 }
        Given url 'https://conduit.productionready.io/api/'

        # path is extension of url. 
        # Url is valid all time during execution of Scenario.
        # lifetime of path is only during test.
        Given path 'articles'
        When method Get
        Then status 200
    # End of Scenario

    