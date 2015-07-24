Feature: Hidden Fields

  Background:
    Given I am on the static elements page

  Scenario: Setting and getting a value from a hidden field
    When I retrieve the hidden field element
    Then I should see the hidden field contains "12345"

  Scenario Outline: Locating hidden fields on the Page
    When I search for the hidden field by "<search_by>"
    Then the hidden field element should contain "12345"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |
    | text      |
    | value     |
    | css       |

  Scenario Outline: Locating a hidden field using multiple parameters
    When I search for the hidden field by "<param1>" and "<param2>"
    Then the hidden field element should contain "12345"

  Scenarios:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |

  Scenario: Finding a hidden field dynamically
    When I find a hidden field while the script is executing
    Then I should see that the hidden field exists
    And the hidden field element should contain "12345"
