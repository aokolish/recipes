Feature: Create Account
  In order to use more of the site features
  As a user
  I want to create an account

  Background:
    Given I am on the new user page

  Scenario: Creating Account - successful
    When I fill in the form with valid input
    Then I should be on the recipes page
    And I should see a message saying my account has been created
    And I should be logged in

  Scenario: Creating Account - failure
    When I fill in the form with invalid input
    Then I should be on the same page
    And I should see a message for each error
