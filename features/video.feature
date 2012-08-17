  @focus
Feature: Support for video element

  Background:
    Given I am on the static elements page

  Scenario: finding an video element
    When I retrieve the video element
    Then I should know it exists
    And I should know it is visible
    
  Scenario Outline: Locating a video element on the page
    When I search for the video element by "<search_by>"
    Then I should know it is visible

  Examples:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |

  Scenario Outline: Locating videos using multiple parameters
    When I search for the video element by "<param1>" and "<param2>"
    Then I should know it is visible

  Examples:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |
