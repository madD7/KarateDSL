Feature: Create Token
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
        * def authToken = response.user.token
