Feature: Page level actions
  In order to act on pages from a web site
  Testers will need to use the page object to encapsulate access

  Background:
    Given I am on the static elements page


  Scenario: Getting the text from a web page
    Then the page should contain the text "Static Elements Page"

  Scenario: Getting the html from a web page
    Then the page should contain the html "<title>Static Elements Page</title>"

  Scenario: Getting the title from a web page
    Then the page should have the title "Static Elements Page"

  Scenario: Waiting for something
    Then I should be able to wait for a block to return true

  Scenario: Handling alert popups
    When I handle the alert
    Then I should be able to get the alert's message

  Scenario: Handling confirm popups
    When I handle the confirm
    Then I should be able to get the confirm message

  Scenario: Handling prompt popups
    When I handle the prompt
    Then I should be able to get the message and default value
