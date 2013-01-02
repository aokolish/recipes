Feature: Creating a Recipe
  In order to share my own recipes
  As a user
  I can add a recipe to the site

  Scenario: Adding Recipe
    Given I am logged in
    When I submit a valid recipe
    Then I should be on the new recipe page
    And it should say that the recipe was created
