Feature: New viewer visit the Home Page
  In order to see the app
  As a new viewer
  I want to see the welcome page of my application

  Scenario: New viewer visits home page
    Given I am on the home page
    And I am a not a user
    Then I should see "Welcome to Grub Haus!"

Feature: Signed in viewer visits the Home Page
  In order to see the app
  As a new viewer
  I want to see new recipes that have been posted

  Scenario: User visit home page
    Given I am on the homepage
    And I am a user
    Then I should see a list of recipe postings
