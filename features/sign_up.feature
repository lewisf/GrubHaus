Feature: Viewer wants to sign up for GrubHaus
  As a potential user
  So that I can sign up
  I should be presented with a method of signing up

  Scenario: Viewer is not yet a user and wants to sign up
    Given I am on the GrubHaus home page
    And I am a not a user
    Then I should see "Sign Up"
    And if I click "Sign Up"
    Then I should be on the registration page