Feature: Elements

  Scenario: Clear an element
    Given I am on the static elements page
    When I type "abcDEF" into the text field
    Then the text field should contain "abcDEF"
    When I clear the text field
    Then the text field should contain ""
