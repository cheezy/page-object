Feature: Unordered list

  Background:
    Given I am on the static elements page
  
  Scenario: Getting the first element from the unordered list
    When I get the first item from the unordered list
    Then the list items text should be "Item One"

  Scenario Outline: Locating unordered lists on the page
    When I search for the unordered list by "<search_by>"
    And I get the first item from the list
    Then the list items text should be "Item One"
    And the list should contain 3 items
    And each item should contain "Item"
  
  Scenarios:
    | search_by |
    | id        |
    | class     |
    | xpath     |  

  @watir_only
  Scenario Outline: Locating unordered lists in Watir only
    When I search for the unordered list by "<search_by>"
    And I get the first item from the list
    Then the list items text should be "Item One"

  Scenarios:
    | search_by |
    | index     |

  @selenium_only
  Scenario Outline: Locating unordered lists in Selenium only
    When I search for the unordered list by "<search_by>"
    And I get the first item from the list
    Then the list items text should be "Item One"

  Scenarios:
    | search_by |
    | name      |
