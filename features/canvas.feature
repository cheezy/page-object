Feature:  Support for the canvas element

  Background:
    Given I am on the static elements page

  Scenario: Retrieve a canvas element
    When I retrieve the canvas element
    Then I should know it exists
    And I should know it is visible

  Scenario Outline: Locating a canvas on the page
    When I search for the canvas by "<search_by>"
    Then I should know it is visible

  Examples:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |
    | css       |

  Scenario: Determining the width and height of the canvas
    When I retrieve the canvas element
    Then I should see that the canvas width is "200"
    And I should see that the canvas height is "100"

  Scenario Outline: Locating canvases using multiple parameters
    When I search for the canvas element by "<param1>" and "<param2>"
    Then I should know it is visible

  Scenarios:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |

