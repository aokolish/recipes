Feature: Adding Pictures of Recipes

  Scenario: Adding two pictures
    Given I am logged in
    When I go to the pictures page
    And add two pictures with captions
    Then I should see the pictures and the captions
    And I should see them on the recipe and the recipes page


  # Give I am logged in
  # When I edit a repipe with two photos
  # And I drag the thumbnails
  # Then I can sort the photos

  # things to test:
    # adding a photo
    # adding a second one
    # viewing picture captions
  # changing the order by dragging pictures
  # inline editing of captions
