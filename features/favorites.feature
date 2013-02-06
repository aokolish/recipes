Feature: Favorites
  In order to save the best recipes
  As a user
  I can favorite recipes

  Scenario: Adding Favorite
    Given I am logged in
    When I favorite a recipe on the recipe page
    Then it should say that the favorite was added

  Scenario: Adding Favorite - logged out
    When I visit a recipe page
    Then there is no favorite link

  Scenario: Removing Favorite
    Given I have an existing favorite
    When I click the remove favorite link
    Then it should say that the favorite was removed

