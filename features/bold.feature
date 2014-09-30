Feature: Bold

  Background:
    Given I am on the static elements page

  Scenario: Getting the text of headings
    When I get the bold text for the "b" element
    Then I should see "some text in bold" in bold

  Scenario Outline: Locating b on the Page
    When I search bold text for the b by "<search_by>"
    Then I should see "some text in bold" in bold

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |
    | css       |
