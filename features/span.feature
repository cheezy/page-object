Feature: Span

  Background:
    Given I am on the static elements page

  Scenario: Getting the text from a span
    When I get the text from the span
    Then the text should be "My alert"

  Scenario Outline: Locating spans on the page
    When I search for the span by "<search_by>"
    Then the text should be "My alert"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | xpath     |
    | index     |
    | name      |
    | text      |
    | title     |
    | css       |

  Scenario Outline: Locating span using multiple parameters
    When I search for the span by "<param1>" and "<param2>"
    Then the text should be "My alert"

  Scenarios:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |

  Scenario: Finding a span dynamically
    When I get the text from a span while the script is executing
    Then I should see that the span exists
    And the text should be "My alert"
