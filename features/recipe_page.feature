Feature: Viewer visits the page of a recipe
  In order to see a recipe
  As a viewer
  I want to see a recipe
  
  Scenario: New viewer visits a recipe page
    Given I am on a recipe page
    And I am not a user
    Then I should see a recipe page
    
  Scenario: New viewer wants to interact with a recipe page
    Given I am on a recipe page
    And I am not a user
    Then I should be prompted to sign up / sign in
    
  Scenario: New viewer wants to share a recipe
    Given I am on a recipe page
    And I am not a user
    Then I should be given choices on how to share

  Scenario: User visits a recipe page
    Given I am on a recipe page
    And I am a user
    Then I should see a recipe page

  Scenario: User wants to favorite a recipe
    Given I am on a recipe page
    And I am a user
    Then I should be able to favorite a recipe

  Scenario: User wants to follow the author
    Given I am on a recipe page
    And I am a user
    Then I should be able to follow the author of the recipe

  Scenario: User wants to comment on a recipe
    Given I am on a recipe page
    And I am a user
    Then I should be able to comment on a recipe

  Scenario: User wants to rate a recipe
    Given I am on a recipe page
    And I am a user
    Then I should be able to submit ratings for a recipe

  Scenario: User should be able to add tips to steps
    Given I am on a recipe page
    And I am a user
    Then I should be able to add tips to steps