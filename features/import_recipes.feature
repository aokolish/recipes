Feature: Import Recipes
  In order to quickly add recipes to the site
  As a user
  I can import recipes from some sites

  Background:
    Given I am logged in
    And I am on the import page

  @javascript
  Scenario: Importing a Recipe
    When I submit the import form
    Then a recipe should be created

  @javascript
  Scenario: Importing - existing recipe
    When I import the same recipe twice
    Then I should see a message saying the recipe has already been imported

  @javascript
  Scenario: Importing - unsupported site
    When I try to import from an unsupported site
    Then I should see a message saying that cannot be done
