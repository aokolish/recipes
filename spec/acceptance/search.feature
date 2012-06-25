Feature: Recipe Pictures
  In order to find recipes
  As a user
  I want to search and sort them

  Scenario: Sorting Search Results
    Given three recipes come up in my search results
    When I click the 'Date Created' sort button
    Then the search results should be ordered by date created descending
    And when I click it again
    Then the search results should be ordered by date created ascending
    When I click the 'Best Match' sort button
    Then I should see the original search results
