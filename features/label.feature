Feature: Handling labels with page object

  In order to interact with labels,
  Testers will need to access the element
  and the ability to interrogate

  Background:
    Given I am on the static elements page

  Scenario: Getting the text from a label
    When I get the text from the label
    Then the text should be "page-object is the best!"

  Scenario: Getting the label element
    When I retrieve the label element
    Then I should know it exists
    And I should know it is visible

  Scenario Outline: Locating labels on the page
    When I search for the label by "<search_by>"
    Then the text should be "page-object is the best!"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | xpath     |
    | index     |
    | name      |
    | text      |
    | css       |

  Scenario Outline: Locating labels using multiple parameters
    When I search for the label by "<param1>" and "<param2>"
    Then the text should be "page-object is the best!"

  Scenarios:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |

  Scenario: Finding a label dynamically
    When I get the text from a label while the script is executing
    Then I should see that the label exists
    And the text should be "page-object is the best!"

