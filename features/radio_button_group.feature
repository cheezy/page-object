Feature: Radio Button Groups
  In order to interact with radio button groups
  Testers will need access and interrogation ability


  Background:
    Given I am on the static elements page

  Scenario: Confirm existence of a radio button group
    When a page has a radio button group
    Then I should see that the radio button group exists

  Scenario: No radio buttons in the group have been selected
    When no radio buttons have been selected
    Then no radio buttons should be selected

  Scenario: Selecting grouped radio buttons by text
    When I select the "Cheddar" radio button
    Then the "Cheddar" radio button should be selected
    Then the "Emmental" radio button should not be selected
    Then the "Muenster" radio button should not be selected
    When I select the "Emmental" radio button
    Then the "Cheddar" radio button should not be selected
    Then the "Emmental" radio button should be selected
    Then the "Muenster" radio button should not be selected

  Scenario: Selecting grouped radio buttons by value
    When I select the "ched" radio button
    Then the "Cheddar" radio button should be selected
    Then the "Emmental" radio button should not be selected
    Then the "Muenster" radio button should not be selected
    When I select the "muen" radio button
    Then the "Cheddar" radio button should not be selected
    Then the "Emmental" radio button should not be selected
    Then the "Muenster" radio button should be selected

  Scenario: Getting an array of elements for each radio button in the group
    When I ask for the elements of a radio button group
    Then I should have an array with elements for each radio button
    And the radio button element values should be "ched", "emmen", "muen"
