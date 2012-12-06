Feature: User creates a recipe
  As a signed in user
  I should see a list of steps
  I should see a list of ingredients
  I should see a list of directions
  I should see an area for pictures
  I should see an area for descriptions
  
  Scenario: Try to create a recipe
    Given I am on the home page
    And I am a user
    When I click the create recipe link
    Then I am on the create recipe page
    And I should be able to add a photo, estimated time, description, and ingredients
    
  Scenario: User adds a tag
    Given Iam on the create recipe page
    And I am a user
    Then I should be able to add tags to the recipe