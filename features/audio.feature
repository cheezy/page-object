@focus
Feature:  Support for the audio element

  Background:
    Given I am on the static elements page

  Scenario: finding an audio element
    When I retrieve the audio element
    Then I should know it exists
    And I should know it is visible
