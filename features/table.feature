Feature: Table
  In order to interact with tables
  Testers will need access and interrogation ability

  
  Background:
    Given I am on the static elements page
  
  Scenario: Retrieve a table
    When I retrieve a table element
    Then I should know it exists
    And I should know it is visible
    
  Scenario: Retrieve a cell from a table by id
    When I retrieve table cell
    Then I should know it exists
    And I should know it is visible


#  Scenario: Retrieve the data from a table
#    When I retrieve a table element
#    Then the data for row "1" should be "Data1" and "Data2"
#    And the data for row "2" should be "Data3" and "Data4"
  
  
  