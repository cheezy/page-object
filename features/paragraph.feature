Feature: Paragraph

  Background:
    Given I am on the static elements page

  Scenario: Getting the text from a paragraph
    When I get the text from the paragraph
    Then the text should be "Static Elements Page"

  Scenario Outline: Locating paragraphs on the page
    When I search for the paragraph by "<search_by>"
    Then the text should be "Static Elements Page"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | xpath     |
    | index     |
    | name      |
    | css       |

  Scenario Outline: Locating paragraphs using multiple parameters
    When I search for the paragraph by "<param1>" and "<param2>"
    Then the text should be "Static Elements Page"

  Scenarios:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |

  Scenario: Finding a paragraph dynamically
    When I get the text from a paragraph while the script is executing
    Then I should see that the paragraph exists
    And the text should be "Static Elements Page"
