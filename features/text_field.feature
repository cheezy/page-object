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

  @watir_only
  Scenario Outline: Locating text fields on Watir only
    When I search for the text field by "<search_by>"

  Scenarios:
    | search_by |
    | index     |
    | text      |
    | value     |

