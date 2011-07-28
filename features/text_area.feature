Feature: Text Area


  Background:
    Given I am on the static elements page

  Scenario: Setting and getting a value from a text area
    When I type "abcdefghijklmnop" into the text area
    Then the text area should contain "abcdefghijklmnop"

  Scenario Outline: Locating text area on the Page
    When I search for the text area by "<search_by>"
    Then I should be able to type "I found it" into the area

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | css       |
    | tag_name  |
    | index     |


  Scenario Outline: Locating a text area using multiple parameters
    When I search for the text area by "<param1>" and "<param2>"
    Then I should be able to type "I found it" into the area

  Scenarios:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |
