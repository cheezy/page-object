Feature: Handling Asynch calls

  Scenario: Link element methods
    Given I am on the static elements page
    When I retrieve a link element
    Then I should be able to wait until it is present
    And I should be able to wait until it is visible
    And I should be able to wait until it is not visible
    And I should be able to wait until a block returns true

  Scenario: Click a button when it is visible
    Given I am on the async elements page
    When I make the button invisible
    Then I should be able to click it when it becomses visible

  Scenario: Wait until something is not visible
    Given I am on the async elements page
    Then I should be able to wait until the button becomes invisible

  Scenario: Wait for an element to appear on the page
    Given I am on the async elements page
    When I add a button a few seconds from now
    Then I should be able to click it when it gets added

  Scenario: Wait for an element to disappear from the page
    Given I am on the async elements page
    When I add a button a few seconds from now
    And I remove a button a few seconds from now
    Then I should not be able to find the button
   
