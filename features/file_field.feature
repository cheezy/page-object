Feature: File Field

  Background:
    Given I am on the static elements page

  Scenario: Setting the value on the file field
    When I set the file field to the step definition file
    Then its' value should equal that file
