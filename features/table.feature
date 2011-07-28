Feature: Table
  In order to interact with tables
  Testers will need access and interrogation ability


  Background:
    Given I am on the static elements page

  Scenario: Retrieve a table
    When I retrieve a table element
    Then I should know it is visible

  @watir_only
  Scenario: Determine if a table exists
    When I retrieve a table element
    Then I should know it exists

  Scenario: Retrieve the data from a table
    When I retrieve a table element
    Then the data for row "1" should be "Data1" and "Data2"
    And the data for row "2" should be "Data3" and "Data4"
    And the table should have "2" rows
    And each row should contain "Data"
    And row "1" should have "2" columns
    And each column should contain "Data"

  Scenario Outline: Locating table cells on the Page
    When I retrieve a table element by "<search_by>"
    Then the data for row "1" should be "Data1" and "Data2"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | xpath     |
    | index     |
    | name      |

  Scenario Outline: Locating table using multiple parameters
    When I retrieve a table element by "<param1>" and "<param2>"
    Then the data for row "1" should be "Data1" and "Data2"

  Scenarios:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |
