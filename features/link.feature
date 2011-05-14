Feature: Links
  In order to interact with links
  Testers will need access and integoration ability

  Note:
    Watir supports text, href, url, html, index, src finder.
    Selenium supports link, link_text, and partial_link_text finder.

  Background:
    Given I am on the static elements page
  
  Scenario: Selecting a link
    When I select the link labeled "Google Search"
    Then the page should contain the text "Google"

  Scenario Outline: Locating links on the Page
    When I search for the link by "<search_by>"
    Then I should be able to select the link

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |

