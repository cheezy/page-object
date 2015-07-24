Feature: Select List
  In order to interact with select lists
  Testers will need access and interrogation ability


  Background:
    Given I am on the static elements page

  Scenario: Selecting an element on the select list
    When I select "Test 2" from the select list
    Then the current item should be "Test 2"
    
  Scenario: Selecting an element when there is a forward slash
    When I select "Test/Test 3" from the select list
    Then the current item should be "Test/Test 3"

  Scenario Outline: Locating select lists on the Page
    When I search for the select list by "<search_by>"
    Then I should be able to select "Test 2"
    And the value for the selected item should be "Test 2"
    And the value for the option should be "option2"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |
    | label     |
    | css       |

  Scenario Outline: Locating a select list using multiple parameters
    When I search for the select list by "<param1>" and "<param2>"
    Then I should be able to select "Test 2"
    And the value for the selected item should be "Test 2"
    And the value for the option should be "option2"

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
    Then I should see that the select list exists
    And I should be able to select "Test 2" from the list

  Scenario: Getting the selected option
    When I select "Test 2" from the select list
    Then the selected option should be "Test 2"

  Scenario: Determining if a select list includes some option
    Then the select list should include "Test 2"

  Scenario: It should know if an option is selected
    When I select "Test 2" from the select list
    Then the select list should know that "Test 2" is selected

  Scenario: Clearing multiple select list
    When I clear multiple select list
    Then multiple select list should have no selected options

  Scenario: Selecting an option by its value
    When I select an option using the value "option2"
    Then the selected option should be "Test 2"

  Scenario: Getting the value from a selected option
    When I select an option using the value "option2"
    Then the selected option should have a value of "option2"
