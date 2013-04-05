Feature: Area

  Background:
    Given I am on the static elements page

  Scenario: Retrieve an area element
    When I retrieve the area element
    Then I should know it exists
    And I should know it is visible

  Scenario Outline: Locating areas on the page
    When I search for the area by "<search_by>"
    Then I should be able to click the area

  Examples:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |
    | css       |

  Scenario: Getting the coordinates for the area
    When I retrieve the area element
    Then I should see the coordinates are "0,0,82,126"

  Scenario: Getting the shape for the area
    When I retrieve the area element
    Then I should see the shape is "rect"

  Scenario: Getting the href from the area
    When I retrieve the area element
    Then I should see the href is "sun.html"

