Feature: Page level actions
  In order to act on pages from a web site
  Testers will need to use the page object to encapsulate access


  @watir
  Scenario: Getting the text from a web page using Watir
    Given I am on the static elements page
    Then the page should contain the text "Static Elements Page"

  @selenium
  Scenario: Getting the text from a web page using Selenium
    Given I am on the static elements page
    Then the page should contain the text "Static Elements Page"  
  
  
