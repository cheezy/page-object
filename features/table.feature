Feature: Table
  In order to interact with tables
  Testers will need access and interrogation ability


  Background:
    Given I am on the static elements page

  Scenario: Retrieve a table
    When I retrieve a table element
    Then I should know it is visible

  Scenario: Determine if a table exists
    When I retrieve a table element
    Then I should know it exists

  Scenario: Retrieve the data from a table
    When I retrieve a table element
    Then the data for row "2" should be "Data1" and "Data2"
    And the data for row "3" should be "Data3" and "Data4"
    And the table should have "3" rows
    And row "2" should have "2" columns
    And the data for the second row should be "Data1" and "Data2"
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
    Then the data for column "Header" and row "3" should be "Data4"

  Scenario: Retrieve data from a table with a thead using a column header
    When I retrieve a table with thead element
    Then the data for column "Col1" and row "2" should be "Data1"

  Scenario: Retrieve data from the first row of a table with a thead using a column header
    When I retrieve a table with thead element
    Then the data for column "Col1" and row "1" should be "Col1"

  Scenario: Retrieve data from a table using a partial column header
    When I retrieve a table element
    Then the data for column "eader" and row "3" should be "Data4"

  Scenario: Retrieve data from a table using both headers
    When I retrieve a table element
    Then the data for row "Data3" and column "eader" should be "Data4"

  Scenario: Retrieve data from a table with an incorrect row header
    When I retrieve a table element
    Then the data for row "Data20" should be nil

  Scenario: Retrieve data from a table with an incorrect column header
    When I retrieve a table element
    Then the data for row "Data3" and column "Data20" should be nil

  Scenario: Retrieve data from a table that does not have a cell which corresponds to a column header
    When I retrieve a table with thead element
    Then the data for row "Data5" and column "Col2" should be nil

  Scenario Outline: Locating table cells on the Page
    When I retrieve a table element by "<search_by>"
    Then the data for row "2" should be "Data1" and "Data2"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | xpath     |
    | index     |
    | name      |
    | css       |

  Scenario: Matching the expected table with the table on the Page
    When I retrieve a table element
    Then the table should be like the expected one
      | Table | Header |
      | Data1 | Data2  |
      | Data3 | Data4  |

  Scenario Outline: Locating table using multiple parameters
    When I retrieve a table element by "<param1>" and "<param2>"
    Then the data for row "2" should be "Data1" and "Data2"

  Scenarios:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |

  Scenario: Finding a table dynamically
    When I retrieve a table element while the script is executing
    And the data for row "2" should be "Data1" and "Data2"

  @watir_only
  Scenario: Finding an existing table
    Then I should see that the table exists

  Scenario: Getting the text from a table
    Then I should see the text includes "Data1" when I retrieve it by "id"
    And I should see the text includes "Data2" when I retrieve it by "id"
