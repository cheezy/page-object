Feature: Italic

  Background:
    Given I am on the static elements page

  Scenario: Getting the text of headings
    When I get the italic text for the "i" element
    Then I should see "some text in italic" in italic

  Scenario Outline: Locating i on the Page
    When I search italic text for the i by "<search_by>"
    Then I should see "some text in italic" in italic

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |
    | css       |
