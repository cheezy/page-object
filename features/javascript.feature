Feature: Handling javascript events
  
  Background:

  Scenario: Waiting for ajax to complete with jQuery
    Given I am on jQuery example page
    When I ask to compute "2 + 2"
    Then I should be able to wait for the answer "4"

  Scenario: Waiting for ajax to complete with Prototype
    Given I am on the Prototype example page
    When I ask to compute "2 + 2"
    Then I should be able to wait for the answer "4"

  Scenario: Executing javascript in the browser
    Given I am on the static elements page
    Given I execute the javascript "return 2 + 2;"
    Then I should get the answer "4"
