Feature: Button
  In order to interact with buttons
  Testers will need access and interrogation ability


  Background:
    Given I am on the static elements page

  Scenario: Getting the text from a div
    When I click the button
    Then I should be on the success page

  Scenario: Retrieve a button element
    When I retrieve a button element
    Then I should know it exists
    And I should know it is visible

  Scenario Outline: Locating buttons on the page
    When I search for the button by "<search_by>"
    Then I should be able to click the button

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |

  @watir_only
  Scenario Outline: Locating buttons on Watir only
    When I search for the button by "<search_by>"
    Then I should be able to click the button

  Scenarios:
    | search_by |
    | text      |

  Scenario Outline: Locating button using multiple parameters
    When I search for the button by "<param1>" and "<param2>"
    Then I should be able to click the button

  Scenarios:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |
