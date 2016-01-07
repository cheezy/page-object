Feature: Handling Asynch calls

  Background:
    Given I am on the async elements page
  
  Scenario: Click a button when it is visible
    When I make the button invisible
    Then I should be able to click it when it becomses visible

  Scenario: Wait until something is not visible
    Then I should be able to wait until the button becomes invisible

  Scenario: Wait for an element to appear on the page
    When I add a button a few seconds from now
    Then I should be able to click it when it gets added

  Scenario: Wait for an element to disappear from the page
    When I add a button a few seconds from now
    And I remove a button a few seconds from now
    Then I should not be able to find the button
   
