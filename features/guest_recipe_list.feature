Feature: New viewer visits the recipe listing
  In order to see recipes
  As a new viewer
  I want to see a list of recipes on grubhaus

  Scenario: New viewer visits recipes page
    Given I am on the recipes page
    And I am not a user
    Then I should see a list of recent recipes

  Scenario: New viewer visits gallery page
    Given I am on the recipes page
    And I am not a user
    Then I should see a gallery of recent recipes