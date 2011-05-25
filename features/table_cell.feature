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
  

  @watir_only
  Scenario Outline: Locating table cells on the Page with watir
    When I search for the table cell by "<search_by>"
    Then the cell data should be 'Data4'

  Scenarios:
    | search_by |
    | index     |

  @selenium_only
  Scenario Outline: Locating table cells on the Page with watir
    When I search for the table cell by "<search_by>"
    Then the cell data should be 'Data4'

  Scenarios:
    | search_by |
    | name      |

