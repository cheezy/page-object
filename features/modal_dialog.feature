Feature: handing modal dialogs

  Background:
    Given I am on the modal page


  Scenario: Interacting with a modal dialog
    When I open a modal dialog
    Then I should be able to close the modal

