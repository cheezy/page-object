Feature: Page level actions
  In order to act on pages from a web site
  Testers will need to use the page object to encapsulate access


  Scenario: Getting the text from a web page
    Given I am on the static elements page
    Then the page should contain the text "Static Elements Page"

  Scenario: Getting the html from a web page
    Given I am on the static elements page
    Then the page should contain the html "<title>Static Elements Page</title>"

  Scenario: Getting the title from a web page
    Given I am on the static elements page
    Then the page should have the title "Static Elements Page"

  
  
