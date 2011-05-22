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

  @watir_only
  Scenario Outline: Locating select lists on Watir only
    When I search for the select list by "<search_by>"
    Then I should be able to select "Test 2"
    And the value for the selected item should be "option2"

    Scenarios:
      | search_by |
      | index     |
#      | value     |
#      | text      |

  Scenario: Retrieve a select list
    When I retrieve a select list
    Then I should know it exists
    And I should know it is visible
