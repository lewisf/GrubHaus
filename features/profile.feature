Feature: Viewer views a user profile
    In order to see a user's profile page
    As a viewer
    I should be able to see his user information

    Scenario: Viewer visits a user's profile
      Given I am on a user's profile page
      And I am a viewer
      Then I should see a username
      And I should be able to see a list of recipes that he owns
      And I should be able to see a list of recipes that he has favorited
      And I should be able to see a list of tags he's following
      And I should be able to see a list of who he's following
      
    Scenario: Viewer visits a user's profile
      Given I am a user's profile page
      And I am a user
      Then I should be able to follow the user
      And I should be able to send the user a message
      And I should be able to comment on a user's profile