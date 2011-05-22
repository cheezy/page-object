Feature: Table
  In order to interact with tables
  Testers will need access and interrogation ability

  
  Background:
    Given I am on the static elements page
  
    Scenario: Retrieve a table
      When I retrieve a table element
      Then I should know it exists
      And I should know it is visible
