Feature: Table Cell


  Background:
    Given I am on the static elements page

  Scenario: Retrieving the text from a table cell
    When I retrieve the data from the table cell
    Then the cell data should be 'Data4'

  Scenario Outline: Locating table cells on the Page
    When I search for the table cell by "<search_by>"
    Then the cell data should be 'Data4'

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | xpath     |
    | name      |
    | text      |
    | css       |

  @watir_only
  Scenario Outline: Locating table cells on the Page with watir
    When I search for the table cell by "<search_by>"
    Then the cell data should be 'Data4'

  Scenarios:
    | search_by |
    | index     |

  Scenario Outline: Locating table cell using multiple parameters
    When I retrieve a table cell element by "<param1>" and "<param2>"
    Then the cell data should be 'Data4'

  Scenarios:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |

  Scenario: Finding a table cell dynamically
    When I retrieve a table cell element while the script is executing
    Then I should see that the cell exists
    And the cell data should be 'Data4'
