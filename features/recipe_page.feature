Feature: Viewer visits the page of a recipe
  In order to add value to our service
  Viewer should be able to see and 
  interact with recipes. 
  
  Scenario: Viewer wants to interact with a recipe page
    Given I am on a recipe page
    And I am not a user
    Then I should see a recipe with instructions
    And if I press any link to interact with the recipe
    Then I should be prompted to sign up or sign in
    
  Scenario: New viewer wants to share a recipe
    Given I am on a recipe page
    And I am not a user
    And I click a link to share the recipe
    Then I should be prompted with methods to share the recipe

  Scenario: User wants to favorite a recipe
    Given I am on a recipe page
    And I am a user
    And I click a link to favorite the recipe
    Then I should have favorited the recipe
    And I should be prompted with a notice that the action was successful

  Scenario: User wants to follow the author
    Given I am on a recipe page
    And I am a user
    And I click on the author of the recipe
    Then I should be on a profile page
    And if I click follow
    Then I should be following the author
    And I should be prompted with a notice that the action was successful

  Scenario: User wants to comment on a recipe
    Given I am on a recipe page
    And I am a user
    And I type into the comment box
    And I press submit
    Then I am on a recipe page
    And I should see my comment

  Scenario: User wants to rate a recipe
    Given I am on a recipe page
    And I am a user
    Then I should be able to submit ratings for a recipe
    And if I submit a rating
    Then I should be prompted with a notice that the action was successful

  Scenario: User should be able to add tips to steps
    Given I am on a recipe page
    And I am a user
    Then I should be able to add tips to steps
    And If I click to add a tip to a step
    Then I should be given a input box
    And If I type into the input box
    And Submit
    Then I should be prompted with a notice that the action was successful