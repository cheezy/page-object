Feature: Gxt Table Extension
  As a Quality Engineer working on a Gxt or Gwt project
  In order to easily create test widgets to interact with application widgets
  I need to define, register and use widgets as if they were normal elements

  Background:
    Given I have defined a GxtTable class extending Table
    And I have registered the GxtTable with PageObject
    And I define a page-object using that widget
    And I am on the Gxt Examples page

  Scenario: Retrieve a GxtTable
    When I retrieve a GxtTable widget
    Then I should know it is visible

  @watir_only
  Scenario: Determine if a GxtTable exists
    When I retrieve a GxtTable widget
    Then I should know it exists

  Scenario: Confirm a correct row count from a GxtTable
    When I retrieve a GxtTable widget
    Then the GxtTable should have "3" rows
