Feature: Area

  Background:
    Given I am on the static elements page

  Scenario: Retrieve an area element
    When I retrieve an area element
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
