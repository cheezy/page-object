Feature: Text Fields
  In order to interact with text fields
  Testers will need access and interrogation ability


  Background:
    Given I am on the static elements page

  Scenario: Setting and getting a value from a text field
    When I type "abcDEF" into the text field
    Then the text field should contain "abcDEF"

  Scenario Outline: Locating text fields on the Page
    When I search for the text field by "<search_by>"
    Then I should be able to type "I found it" into the field

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | css       |
    | tag_name  |
    | index     |

  Scenario Outline: Locating a text field using multiple parameters
    When I search for the text field by "<param1>" and "<param2>"
    Then I should be able to type "I found it" into the field

  Scenarios:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |

  Scenario: Retrieve a text field
    When I retrieve a text field
    Then I should know it exists
    And I should know it is visible

  Scenario: Finding a text field dynamically
    When I find a text field while the script is executing
    Then I should be able to type "I found it" into the field element
