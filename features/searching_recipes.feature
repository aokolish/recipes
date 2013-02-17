Feature: Searching Recipes
  In order to find recipes
  As a user
  I want to search and sort them

  @javascript
  Scenario: Normal Searching
    Given a recipe exists
    When I search for it by title
    Then it should come up in the results

  @javascript
  Scenario: Sorting Search Results
    Given three recipes come up in my search results
    When I click the 'Date Created' sort button
    Then the results should be ordered by date (desc)
    And when I click it again
    Then the results should be ordered by date ascending
    When I click the 'Best Match' sort button
    Then I should see the original search results

  @javascript
  Scenario: No Results
    When I search and get no results
    Then I should see that nothing was found
