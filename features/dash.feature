Feature: User visits his dashboard
  As a signed in user
  So that I can manage my website
  I should see a list of my own recipes
  I should see a list of my favorited recipes
  I should see a list of recipes that follow my tags
  
  Scenario: User wants to manage his own recipes
    Given I am on my home page
    And I am a user
    Then I should see a list of recipes I've made
    And if I click on one of the recipes
    Then I should be on a recipe page
    And be presented with a way to edit the recipe
    
  Scenario: User wants to see his favorites
    Given I am on my home page
    And I am a user
    Then I should see a list of my favorites
    And be able to search through my favorites
    
  Scenario: User wants to see recipes of things he tags
    Given I am on my home page
    And I am a user
    Then I should be able to see a list of recipes that fall into the tags I am following
    And I should be able to add more tags to follow