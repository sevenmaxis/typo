Feature: Merge articles
  As a blog adminitrator
  In order to combine articles with similar content
  I want to be able to merge two articles

  Background:
    Given the blog is set up
    And I am logged into the admin panel
    And I as admin have published article "To be merged A" with content "Lorem ipsum dolor sit amet, ..."
    And Article "To be merged A" has comment "First comment for A"
    And I as admin have published article "To be merged B" with content "this is merged"
    And Article "To be merged B" has comment "First comment for B"

  Scenario: Creating a new article and not being allowed to merge
    Given I am on the admin content page
    When I follow the New Article link
    Then I should be on the new article page
    And  I should not see "Merge Articles"
    And  I should not see the "merge_with" textfield
    And  I should not see the "Merge" button

  Scenario: Going to edit page and being allowed to merge
    Given I am on the admin content page
    When I follow the Edit link for article "To be merged A"
    Then I should be on the edit article page for "To be merged A"
    And  I should see "Merge Articles"
    And  I should see the "merge_with" textfield
    And  I should see the "Merge" button

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I am on the admin content page
    When I follow the Edit link for article "To be merged A"
    When I fill in "merge_with" with the ID of article "To be merged B"
    And I press "Merge"
    Then I should be on the edit article page for "To be merged A"
    Then I should see "Lorem ipsum dolor sit amet, ..." before "this is merged!"

  Scenario: When articles are merged, the merged article should contain the comments of both previous articles
    Given I am on the admin content page
    When I follow the Edit link for article "To be merged A"
    When I fill in "merge_with" with the ID of article "to be merged B"
    And I press "Merge"
    Then Article "To be merged A" should have comment "First comment for A"
    And Article "To be merged A" should have comment "First comment for B"

  Scenario: When given a none-existing article ID, the article should remain unchanged and an error messgae is displayd
    Given I am on the admin content page
    When I follow the Edit link for article "To be merged A"
    When I fill in "merge_with" with "77777"
    And I press "Merge"
    Then I should be on the edit article page for "To be merged A"
    And I should see "Lorem ipsum dolor sit amet, ..."
    And I should not see "this is merged!"
    And I should see "Sorry, an article with ID 77777 does not exist."

  Scenario: When given the same article ID, the article should remain unchanged and an error message is displayed
    Given I am on the admin content page
    When I follow the Edit link for article "To be merged A"
    When I fill in "merge_with" with the ID of article "To be merged A"
    And I press "Merge"
    Then I should be on the edit article page for "To be merged A"
    And I should see "Lorem ipsum dolor sit amet, ..."
    And I should not see "this is merged!"
    And I should see "Sorry, you cannot merge with the same article."

  Scenario: When given no article ID, pressing the merge button should redirect to the content page
    Given I am on the admin content page
    When I follow the Edit link for article "To be merged A"
    And I press "Merge"
    Then I should be on the edit article page for "To be merged A"
    And I should see "Sorry, you should give the ID of an article to merge with."
