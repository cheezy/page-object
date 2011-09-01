Feature: handing modal dialogs

  Background:
    Given I am on the modal page


  Scenario: Interacting with a modal dialog
    When I open a modal dialog
    Then I should be able to close the modal
    
  Scenario: Nested modal dialogs
    When I open a modal dialog
    And I open another modal dialog from that one
    #Then I should be able to close both modals

