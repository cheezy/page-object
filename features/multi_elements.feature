Feature: Multi Elements

  Background:
    Given I am on the multi elements page

  Scenario: Selecting buttons
    When I select the buttons with class "button"
    Then I should have 3 buttons
    And the value of button 1 should be "Button 1"
    And the value of button 2 should be "Button 2"
    And the value of button 3 should be "Button 3"
