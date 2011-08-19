Feature: Select List
  In order to interact with select lists
  Testers will need access and interrogation ability


  Background:
    Given I am on the static elements page

  Scenario: Selecting an element on the select list
    When I select "Test 2" from the select list
    Then the current item should be "option2"

  Scenario Outline: Locating select lists on the Page
    When I search for the select list by "<search_by>"
    Then I should be able to select "Test 2"
    And the value for the selected item should be "option2"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |

  Scenario Outline: Locating a select list using multiple parameters
    When I search for the select list by "<param1>" and "<param2>"
    Then I should be able to select "Test 2"
    And the value for the selected item should be "option2"

  Scenarios:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |

  Scenario: Iterating through the options in the select list
    When I search for the select list by "id"
    Then option "1" should contain "Test 1"
    And option "2" should contain "Test 2"
    And each option should contain "Test"

  Scenario: Finding a select list dynamically
    When I find a select list while the script is executing
    Then I should be able to select "Test 2" from the list
