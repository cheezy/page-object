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
    
  Scenario: Validating the page title
    Then the page should have the expected title

  Scenario: Validating the expected element
    Then the page should have the expected element
    
  Scenario: Validating that an expected element does not exist
    Then the page should not have the expected element

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
    
  Scenario: Attach to window using title
    When I open a second window
    Then I should be able to attach to a page object using title
    
  Scenario: Attach to window using url
    When I open a second window
    Then I should be able to attach to a page object using url
    
  Scenario: Refreshing the page
    Then I should be able to refresh the page
    
  Scenario: Going back and forward
    When I select the link labeled "Google Search"
    Then the page should contain the text "Success"
    When I press the back button
    Then the page should contain the text "Static Elements Page"
    When I press the forward button
    Then the page should contain the text "Success"
    
