Feature: Handling Asynch calls

  Background:
    Given I am on the static elements page

  Scenario: Link element methods
    When I retrieve a link element
    Then I should be able to wait until it is present
    And I should be able to wait until it is visible
    And I should be able to wait until it is not visible
    And I should be able to wait until a block returns true