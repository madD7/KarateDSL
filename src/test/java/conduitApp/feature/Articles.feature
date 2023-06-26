# Each feature file always starts with the keyword - Feature: <Description>
Feature: Test for Articles
    
    Background: Define URL
        Given url 'https://conduit.productionready.io/api/' 

        # Login is a common step. Hence, instead of writing it in all scenarios,
        # shifted login step to background section.
        # Step 1. Login
        Given path 'users/login'

        # In Karate, json can be used directly but it must be inline.
        And request {"user": {"email": "karatedemo47@test.com","password": "Abcd#4567"}}
        When method Post
        Then status 200

        # To define a variable, use '* def'. def is keyword.
        * def token = response.user.token

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
        