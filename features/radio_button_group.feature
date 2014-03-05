Feature: Radio Button Groups
  In order to interact with radio button groups
  Testers will need access and interrogation ability


  Background:
    Given I am on the static elements page

  Scenario: Confirm existence of a radio button group
    Then I should see that the radio button group exists

  Scenario: No radio buttons in the group have been selected
    When no radio buttons have been selected
    Then no radio buttons should be selected in the group

  Scenario: Selecting grouped radio buttons by value
    When I select the "ched" radio button in the group
    Then the "ched" radio button should be selected in the group
    And the "emmen" radio button should not be selected
    And the "muen" radio button should not be selected
    When I select the "muen" radio button in the group
    Then the "ched" radio button should not be selected
    And the "emmen" radio button should not be selected
    And the "muen" radio button should be selected in the group

  Scenario: Getting an array of elements for each radio button in the group
    When I ask for the elements of a radio button group
    Then I should have an array with elements for each radio button
    And the radio button element values should be "ched", "emmen", "muen"
