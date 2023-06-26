
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

        Given param limit = 10
        Given param offset = 0
        Given path 'articles'
        When method Get
        Then status 200
    # End of Scenario

    Scenario: Get 10 articles from the page passing object with parameters
        Given params { limit:10, offset:0 }

        # path is extension of url. 
        # Url is valid all time during execution of Scenario.
        # lifetime of path is only during test.
        Given path 'articles'
        When method Get
        Then status 200
    # End of Scenario

    Scenario: Assertion example 
        # match == , match != , match contains, match contains only, match contains any etc. https://github.com/karatelabs/karate        
        Given path 'tags'
        When method Get
        Then status 200
        # response is keyword for response object. Object response has key 'tags' and an array of strings as value.
        # For single value:
        ## And match response.tags contains 'cars'   

        # Array for multiple values, use array:
        # Then print response
        # Then karate.log(response)
        And match response.tags contains ['welcome', 'codebaseShow']
        And match response.tags !contains 'truck'

        # response.tags value is an array. Other datatype can be - #string
        And match response.tags == "#array"
        And match each response.tags == "#string"
    # End of Scenario
    
    Scenario: Get 10 articles assertion example
        Given params { limit:10, offset:0 }
        Given path 'articles'
        When method Get
        Then status 200

        # Value of 'articles' key object, must be an array of size 10
        And match response.articles == '#[10]'
        # Value of 'articlesCount' is number 500
        And match response.articlesCount == 197 
    # End of Scenario