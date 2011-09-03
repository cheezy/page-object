Feature: Attributes on Elements

  Background:
    Given I am on the nested elements page

  Scenario: Finding a link within a div
    When I search for a link located in a div
    Then I should be able to click the nested link
    
  Scenario: Finding a button within a div
    When I search for a button located in a div
    Then I should be able to click the nested button
    
  Scenario: Finding a text field within a div
    When I search for a text field located in a div
    Then I should be able to type "123abc" in the nested text field

  Scenario: Finding a hidden field within a div
    When I search for a hidden field located in a div
    Then I should be able to see that the nested hidden field contains "LeanDog"
    
  Scenario: Finding a text area within a div
    When I search for a text area located in a div
    Then I should be able to type "abcdefg" in the nested text area

  Scenario: Finding a select list within a div
    When I search for a select list located in a div
    Then I shoudl be able to select "Test 2"

    
