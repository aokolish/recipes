Feature: Reviews
  In order to help others find the best recipes
  As a user
  I can review recipes I've made

  @javascript
  Scenario: Reviewing a Recipe
    Given I am logged in
    And a recipe exists
    When I visit the recipe
    And submit a review
    Then my review should show up on the recipe page
    And the rating shows up on the recipe index page

  @javascript
  Scenario: Listing Reviews
    Given I have reviewed recipes before
    When I go to my user page
    Then I see the reviews listed there
