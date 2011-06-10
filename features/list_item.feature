Feature: List item

  Background:
    Given I am on the static elements page
  
  Scenario: Getting the text from a list item
    When I get the text from the list item
    Then the text should be "Item One"

  Scenario Outline: Locating divs on the page
    When I search for the list item by "<search_by>"
    Then the text should be "Item One"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | xpath     |  

  @watir_only
  Scenario Outline: Locating divs on Watir only
    When I search for the list item by "<search_by>"
    Then the text should be "Item One"

  Scenarios:
    | search_by |
    | index     |

  @selenium_only
  Scenario Outline: Locating divs on Watir only
    When I search for the list item by "<search_by>"
    Then the text should be "Item One"

  Scenarios:
    | search_by |
    | name      |
