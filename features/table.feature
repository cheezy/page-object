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
    And the data for the first row should be "Data1" and "Data2"
    And the data for the last row should be "Data3" and "Data4"
    
  Scenario: Retrieve data from a table using a row header
    When I retrieve a table element
    Then the data for row "Data3" should be "Data3" and "Data4"

  Scenario: Retrieve data from a table using a partial row header
    When I retrieve a table element
    Then the data for row "ata3" should be "Data3" and "Data4"

  Scenario: Retrieve data from a table using a row header in the 2nd column
    When I retrieve a table element
    Then the data for row "Data4" should be "Data3" and "Data4"

  Scenario: Retrieve data from a table using a partial row header in the 2nd column
    When I retrieve a table element
    Then the data for row "ata4" should be "Data3" and "Data4"
    
  Scenario: Retrieve data from a table using a column header
    When I retrieve a table element
    Then the data for column "Data2" and row "2" should be "Data4"

  Scenario: Retrieve data from a table using a partial column header
    When I retrieve a table element
    Then the data for column "ata2" and row "2" should be "Data4"
    
  Scenario: Retrieve data from a table using both headers
    When I retrieve a table element
    Then the data for row "Data3" and column "Data2" should be "Data4"
    
  Scenario: Retrieve data from a table with an incorrect row header
    When I retrieve a table element
    Then the data for row "Data20" should be nil

  Scenario: Retrieve data from a table with an incorrect column header
    When I retrieve a table element
    Then the data for row "Data3" and column "Data20" should be nil

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

  Scenario: Finding a table dynamically
    When I retrieve a table element while the script is executing
    And the data for row "1" should be "Data1" and "Data2"

  @watir_only
  Scenario: Finding an existing table
    Then I should see that the table exists
