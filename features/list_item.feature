Feature: List item

  Background:
    Given I am on the static elements page

  Scenario: Getting the text from a list item
    When I get the text from the list item
    Then the text should be "Item One"

  Scenario Outline: Locating list items on the page
    When I search for the list item by "<search_by>"
    Then the text should be "Item One"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | xpath     |
    | index     |
    | name      |
    | text      |
    | css       |

  Scenario Outline: Locating list items using multiple parameters
    When I search for the list item by "<param1>" and "<param2>"
    Then the text should be "Item One"

  Scenarios:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |

  Scenario: Finding a list item dynamically
    When I search for the list item while the script is executing
    Then I should see that the list item exists
    And the text should be "Item One"
