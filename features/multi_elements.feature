Feature: Multi Elements

  Background:
    Given I am on the multi elements page

  Scenario: Selecting buttons
    When I select the buttons with class "button"
    Then I should have 3 buttons
    And the value of button 1 should be "Button 1"
    And the value of button 2 should be "Button 2"
    And the value of button 3 should be "Button 3"

  Scenario: Selecting text_fields
    When I select the text fields with class "textfield"
    Then I should have 3 text fields
    And the value of text field 1 should be "text 1"
    And the value of text field 2 should be "text 2"
    And the value of text field 3 should be "text 3"

  Scenario: Selecting hidden_fields
    When I select the hidden fields with class "hiddenfield"
    Then I should have 3 hidden fields
    And the value of hidden field 1 should be "hidden 1"
    And the value of hidden field 2 should be "hidden 2"
    And the value of hidden field 3 should be "hidden 3"

  Scenario: Selecting text_areas
    When I select the text areas with class "textarea"
    Then I should have 3 text areas
    And the value of text area 1 should be "textarea 1"
    And the value of text area 2 should be "textarea 2"
    And the value of text area 3 should be "textarea 3"

  Scenario: Selecting select_lists
    When I select the select lists with class "selectlist"
    Then I should have 3 select lists
    And the value of select list 1 should be "selectlist 1"
    And the value of select list 2 should be "selectlist 2"
    And the value of select list 3 should be "selectlist 3"

  Scenario: Selecting links
    When I select the link with class "link"
    Then I should have 3 links
    And the text of link 1 should be "link 1"
    And the text of link 2 should be "link 2"
    And the text of link 3 should be "link 3"


