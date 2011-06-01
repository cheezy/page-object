Feature: Span

  Background:
    Given I am on the static elements page
  
  Scenario: Getting the text from a span
    When I get the text from the span
    Then the text should be "My alert"

  Scenario Outline: Locating spans on the page
    When I search for the span by "<search_by>"
    Then the text should be "My alert"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | xpath     |  

  @watir_only
  Scenario Outline: Locating span on Watir only
    When I search for the span by "<search_by>"
    Then the text should be "My alert"

  Scenarios:
    | search_by |
    | index     |
    
    
  @selenium_only
  Scenario Outline: Locating span on Watir only
    When I search for the span by "<search_by>"
    Then the text should be "My alert"

  Scenarios:
    | search_by |
    | name      |
