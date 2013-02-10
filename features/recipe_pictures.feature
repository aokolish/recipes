Feature: Recipe Pictures
  In order to show off what I cook
  As a user
  I want to upload pictures of recipes

  @javascript
  Scenario: Adding two pictures
    Given I am logged in
    When I go to the pictures page
    And add two pictures with captions
    Then I should see the pictures and the captions
    And I should see them on the recipe page
    And I should see the thumbnail on the recipes page

  # things I decided not to test:
    # sorting photos
    # inline editing of captions
