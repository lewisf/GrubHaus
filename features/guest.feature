Feature: New viewer visits the recipe listing
  As a new viewer
  So I can see what grubhaus is about
  I should be presented with a public view of recipes on grubhaus

  Scenario: New viewer visits a recipe page
    Given I am on the recipes page
    And I am not a user
    Then I should see the name of the recipe
    And I should see a picture of the recipe
    And I should see directions on how to make the recipe

  Scenario: New viewer visits gallery page
    Given I am on the recipes page
    And I am not a user
    When I am on the gallery page
    Then I should see a list of the most recently published recipes