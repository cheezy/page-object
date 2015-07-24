Feature: Ordered list

  Background:
    Given I am on the static elements page

  Scenario: Getting the first element from the ordered list
    When I get the first item from the ordered list
    Then the list items text should be "Number One"

  Scenario Outline: Locating ordered lists on the page
    When I search for the ordered list by "<search_by>"
    And I get the first item from the list
    Then the list items text should be "Number One"
    And the list should contain 3 items
    And each item should contain "Number"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | xpath     |
    | index     |
    | name      |
    | css       |

  Scenario Outline: Locating ordered lists using multiple parameters
    When I search for the ordered list by "<param1>" and "<param2>"
    And I get the first item from the list
    Then the list items text should be "Number One"

  Scenarios:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |

  Scenario: Finding a ordered list dynamically
    When I search for the ordered list while the script is executing
    Then I should see that the ordered list exists
    When I get the first item from the list
    Then the list items text should be "Number One"

  Scenario: Getting the test for an ordered list
    Then the text for the ordered list should contain "Number One"
    And the text for the ordered list should contain "Number Two"
    And the text for the ordered list should contain "Number Three"
