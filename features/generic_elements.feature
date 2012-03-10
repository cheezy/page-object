Feature: Generic Elements

  Background:
    Given I am on the static elements page

  Scenario: Getting the text from the article element
    When I get the text from the article
    Then the text should be "HTML 5 Article"

  Scenario: Getting the text from the header element
    When I get the text from the header
    Then the text should be "HTML 5 Header"

  Scenario: Getting the text from the footer element
    When I get the text from the footer
    Then the text should be "HTML 5 Footer"

  Scenario: Getting the text from the summary element
    When I get the text from the summary
    Then the text should be "The summary"

  Scenario: Getting the text from the details element
    When I get the text from the details
    Then the text should be "The summary The details"