Feature: Populate Page With
  In order to quickly fill out forms on a page
  A tester will use the populate_page_with method
  To fill in text, select options, check boxes, and select radio buttons


  Background:
    Given I am on the static elements page

  Scenario:
    When I populate the page with the data:
      | text_field_id   | abcDEF           |
      | text_area_id    | abcdefghijklmnop |
      | sel_list_id     | Test 2           |
      | cb_id           | check            |
      | butter_id       | check            |
      | favorite_cheese | muen             |
    Then the text field should contain "abcDEF"
    And the text area should contain "abcdefghijklmnop"
    And the selected option should be "Test 2"
    And the First check box should be selected
    And the "Butter" radio button should be selected
    And the "muen" radio button should be selected in the group
