Feature: Text Fields
  In order to interact with radio buttons
  Testers will need access and interrogation ability

  
  Background:
    Given I am on the static elements page
  
  Scenario: Selecting and clearing a radio button
    When I select the "Milk" radio button
    Then the "Milk" radio button should be selected
    When I select the "Butter" radio button
    Then the "Butter" radio button should be selected

  Scenario Outline: Locating radio buttons on the Page
    When I search for the radio button by "<search_by>"
    And I select the radio button
    Then the "Milk" radio button should be selected

    Scenarios:
      | search_by |
      | id        |
      | class     |
      | name      |
      | xpath     |  

  @watir_only
  Scenario Outline: Locating radio buttons on Watir only
    When I search for the radio button by "<search_by>"
    And I select the radio button
    Then the "Milk" radio button should be selected

    Scenarios:
      | search_by |
      | index     |
