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
  
  
  Scenario Outline: Locating table cells on the Page
    When I retrieve a table element by "<search_by>"
    Then the data for row "1" should be "Data1" and "Data2"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | xpath     |  
  
  
  @watir_only
  Scenario Outline: Locating table cells on the Page with watir
    When I retrieve a table element by "<search_by>"
    Then the data for row "1" should be "Data1" and "Data2"

  Scenarios:
    | search_by |
    | index     |


  @selenium_only
  Scenario Outline: Locating table cells on the Page with selenium
    When I retrieve a table element by "<search_by>"
    Then the data for row "1" should be "Data1" and "Data2"

  Scenarios:
    | search_by |
    | name      |
