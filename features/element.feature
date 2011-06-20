Feature: Global functionality for Elements
  
  Background:
    Given I am on the static elements page
  
  Scenario: Support for multiple parameters
    When I select a link labeled "Hello" and index "0"
    Then the page should contain the text "Success"
    Given I am on the static elements page
    When I select a link labeled "Hello" and index "1"
    Then the page should contain the text "Success"

