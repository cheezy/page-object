Feature: Text Area

  
  Background:
    Given I am on the static elements page
  
  Scenario: Setting and getting a value from a text area
    When I type "abcdefghijklmnop" into the text area
    Then the text area should contain "abcdefghijklmnop"

  Scenario Outline: Locating text area on the Page
    When I search for the text area by "<search_by>"
    Then I should be able to type "I found it" into the area

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
    When I search for the text area by "<search_by>"
    Then I should be able to type "I found it" into the area

  Scenarios:
    | search_by |
    | index     |

