# Each feature file always starts with the keyword - Feature: <Description>
Feature: Test for Articles
    
    Background: Define URL
        Given url 'https://conduit.productionready.io/api/' 

        # Login is a common step. Hence, instead of writing it in all scenarios,
        # shifted login step to background section.
        # Step 1. Login - in CreateToken.feature

        # tokenResponse is an object that will hold all variables that were defined in CreateToken.feature
        # Using callonce, the function will be called only once, and when we call 2nd scenario, 
        # karate will read token value from its cache and not make call to token feature.
        * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature')
        * def token = tokenResponse.authToken

        # Passing parameter, object - enclosed in {}, to another feature
        # * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') {"email": "karatedemo47@test.com","password": "Abcd#4567"}   
        
        # End of Login step.

    
    Scenario: Create or Post a new Article 
        # Scenario will login first and then post the article.
        # Upon successful login, a token will be returned which will be then 
        # used for authorization when posting the article.

        # Step 2. Post Article
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request { "article": { "title": "One more new Random Article 47", "description": "This is just a demostration article", "body": "Some random statements.\nHello World!\nBye", "tagList": []}}
        When method Post
        Then status 200

        # Executing the test 2nd time, after article is already created once, will result to error
        # the return status will be 422
        And match response.article.title == 'One more new Random Article 47'
    
    @SingleTest
    Scenario: Create and Delete an article
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request { "article" : { "title": "Test Delete Article", "description": "This article is to demonstrate delete article.", "body" : "This article will be created and then deleted.", "tagList": [] }}
        When method Post
        Then status 200
        And match response.article.title == 'Test Delete Article'

        # This will be required for delete operation.
        * def articleId = response.article.slug

        Given header Authorization = 'Token ' + token

        # Delete url = "https://api.realworld.io/api/articles/<articleId>
        Given path 'articles',articleId
        When method Delete
        # 204 - the server has successfully fulfilled the request and that there is no content to send in the response payload body
        Then status 204         

        # Verify that the article is deleted.
        Given params { limit:10, offset:0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.article[0].title != 'Test Delete Article'




