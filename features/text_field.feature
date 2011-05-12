Feature: Text Fields
  In order to interact with text fields
  Testers will need access and integoration ability

  Note:
    Watir supports tag_name finder.
    Selenium supports css finder.

  
  Background:
    Given I am on the static elements page
  
  Scenario: Setting and getting a value from a text field
    When I type "abcDEF" into the text field
    Then the text field should contain "abcDEF"

  Scenario Outline: Locating text fields on the Page
    When I search for the text field by "<search_by>"
    Then I should be able to type "I found it" into the field

  Scenarios:
  | search_by |
  | id        |
  | class     |
  | name      |
  | xpath     |
  
  






