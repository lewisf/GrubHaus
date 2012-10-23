Feature: User creates a recipe
  As a signed in user
  I should see a list of steps
  I should see a list of ingredients
  I should see a list of directions
  I should see an area for pictures
  I should see an area for descriptions
  
  Scenario: Try to create a recipe
    Given I am adding a recipe
    And I am a user
    Then I should be able to add a photo, estimated time, description, and ingredients
    
  Scenario: User adds a tag
    Given I am adding a recipe
    And I am a user
    Then I should be able to tag my recipe with categories