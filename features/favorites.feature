Feature: Favorites
  In order to save the best recipes
  As a user
  I can favorite recipes

  @javascript
  Scenario: Adding Favorite
    Given I am logged in
    When I favorite a recipe on the recipe page
    Then it should say that the favorite was added

  @javascript
  Scenario: Adding Favorite - logged out
    When I visit a recipe page
    Then there is no favorite link

  @javascript
  Scenario: Removing Favorite
    Given I have an existing favorite
    When I click the remove favorite link
    Then it should say that the favorite was removed

