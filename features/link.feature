Feature: Links
  In order to interact with links
  Testers will need access and interrogation ability

  Background:
    Given I am on the static elements page

  Scenario: Selecting a link
    When I select the link labeled "Google Search"
    Then the page should contain the text "Success"

  Scenario Outline: Locating links on the Page
    When I search for the link by "<search_by>"
    Then I should be able to select the link

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | link      |
    | link_text |
    | text      |
    | index     |
    | href      |
    | css       |
    | title     |

  Scenario: Support for multiple parameters
    When I select a link labeled "Hello" and index "0"
    Then the page should contain the text "Success"
    Given I am on the static elements page
    When I select a link labeled "Hello" and index "1"
    Then the page should contain the text "Success"

  Scenario: Retrieve a Link
    When I retrieve a link element
    Then I should know it exists
    And I should know it is visible

  Scenario: Finding a link dynamically
    When I select a link while the script is executing
    And the page should contain the text "Success"

  Scenario: Getting the href for a link
    When I get the href for the link
    Then I should know it was "success.html"

  Scenario: Locating a link using a partial href
    When I get the link using the href success
    Then I should be able to click the link
