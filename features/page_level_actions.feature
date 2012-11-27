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

  Scenario: Handling possible alert popups
    When I handle the possible alert
    Then I should be able to verify the popup didn't have a message

  Scenario: Handling alert popups that reload the page
    When I handle the alert that reloads the page
    Then I should be able to get the alert's message

  Scenario: Handling confirm popups
    When I handle the confirm
    Then I should be able to get the confirm message

  Scenario: Handling possible confirm popups
    When I handle the possible confirm
    Then I should be able to verify the popup didn't have a message

  Scenario: Handling confirm popups that reload the page
    When I handle the confirm that reloads the page
    Then I should be able to get the confirm message

  Scenario: Handling prompt popups
    When I handle the prompt
    Then I should be able to get the message and default value

  Scenario: Handling possible prompt popups
    When I handle the possible prompt
    Then I should be able to verify the popup didn't have a message
    
  Scenario: Attach to window using title
    When I open a second window
    Then I should be able to attach to a page object using title

  Scenario: Attach to window using title with multiple windows
    When I open a second window
    When I open a third window
    Then I should be able to attach to a page object using title
    
  Scenario: Attach to window using url
    When I open a second window
    Then I should be able to attach to a page object using url

  Scenario: Attach to window using url with multiple windows
    When I open a second window
    When I open a third window
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
    
