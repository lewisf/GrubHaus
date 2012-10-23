Feature: Viewer views a user profile
    In order to see a user's profile page
    As a viewer
    I should be able to see his user information

    Scenario: Viewer visits a user's profile
      Given I am on a user's profile page
      And I am a viewer
      Then I should see a username
      Then I should see a profile page
      Then I should be able to see a list of recipes
      Then I should be able to see al ist of tags he's following
      Then I should be able to see a list of who he's following
      
    Scenario: Viewer visits a user's profile
      Given I am a user's profile page
      And I am a user
      Then I should be able to follow the user