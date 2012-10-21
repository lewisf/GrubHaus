Feature: User visits the home_page
  As a signed in user
  I should see a list of my own recipes
  I should see a list of my favorited recipes
  I should see a list of recipes that follow my tags
  
  Scenario: User wants to see his recipes
    Given I am on my home page
    And I am a user
    Then I should see a list of recipes I've made
    
  Scenario: User wants to see his favorites
    Given I am on my home page
    And I am a user
    Then I should see a list of my favorites
    
  Scenario: User wants to see recipes of things he tags
    Given I am on my home page
    And I am a user
    Then I should be able to see a list of recipes that fall into the tags I am following