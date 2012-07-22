@focus
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

  Scenario: Determining the width and height of the canvas
    When I retrieve the canvas element
    Then I should see that the canvas width is "200"
    And I should see that the canvas height is "100"


