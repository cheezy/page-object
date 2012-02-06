Feature: Nested Elements

  Background:
    Given I am on the nested elements page

  Scenario: Finding a link within a div
    When I search for a link located in a div
    Then I should be able to click the nested link
    
  Scenario: Finding a button within a div
    When I search for a button located in a div
    Then I should be able to click the nested button
    
  Scenario: Finding a text field within a div
    When I search for a text field located in a div
    Then I should be able to type "123abc" in the nested text field

  Scenario: Finding a hidden field within a div
    When I search for a hidden field located in a div
    Then I should be able to see that the nested hidden field contains "LeanDog"
    
  Scenario: Finding a text area within a div
    When I search for a text area located in a div
    Then I should be able to type "abcdefg" in the nested text area

  Scenario: Finding a select list within a div
    When I search for a select list located in a div
    Then I should be able to select "Test 2" in the nested select list
    
  Scenario: Finding a file field within a div
    When I search for a file field located in a div
    Then I should be able to set the nested file field

  Scenario: Finding a checkbox within a div
    When I search for a checkbox located in a div
    Then I should be able to check the nested checkbox

  Scenario: Finding a radio button witin a div
    When I search for a radio button located in a div
    Then I should be able to select the nested radio button

  Scenario: Finding a div within a div
    When I search for a div located in a div
    Then I should see the text "page-object rocks!" in the nested div

  Scenario: Finding a span within a div
    When I search for a span located in a div
    Then I should see the text "My alert" in the nested span

  Scenario: Finding a table within a div
    When I search for a table located in a div
    Then the data for row "1" of the nested table should be "Data1" and "Data2"

  Scenario: Finding a table cell within a div
    When I search the second table cell located in a table in a div
    Then the nested table cell should contain "Data2"

  Scenario: Finding an image within a div
    When I search for an image located in a div
    Then the nested image should be "106" pixels wide
    And the nested image should be "106" pixels tall
  
  Scenario: Finding a form within a div
    When I search for a form located in a div
    Then I should be able to submit the nested form
    
  Scenario: Finding an ordered list within a div
    When I search for an ordered list located in a div
    Then the first nested list items text should be "Number One"
    
  Scenario: Finding an unordered list within a div
    When I search for an unordered list located in a div
    Then the first nested list items text should be "Item One"
  
  Scenario: Finding a list item nested in an ordered list within a div
    When I search for a list item nested in an ordered list in a div
    Then I should see the nested list items text should be "Number One"

  Scenario: Finding a h1 within a div
    When I search for a h1 located in a div
    Then I should see the nested h1s text should be "h1's are cool"
    
  Scenario: Finding a h2 within a div
    When I search for a h2 located in a div
    Then I should see the nested h2s text should be "h2's are cool"
    
  Scenario: Finding a h3 within a div
    When I search for a h3 located in a div
    Then I should see the nested h3s text should be "h3's are cool"

  Scenario: Finding a h4 within a div
    When I search for a h4 located in a div
    Then I should see the nested h4s text should be "h4's are cool"

  Scenario: Finding a h5 within a div
    When I search for a h5 located in a div
    Then I should see the nested h5s text should be "h5's are cool"

  Scenario: Finding a h6 within a div
    When I search for a h6 located in a div
    Then I should see the nested h6s text should be "h6's are cool"

  Scenario: Finding a paragraph within a div
    When I search for a paragraph located in a div
    Then I should see the nested paragraphs text should be "This is a paragraph."
    
  Scenario: Unordered List nested in another Unordered List
    When I get the outter unordered list
    Then I should see "One" for list item 1
    And I should see "Two" for list item 2
    And I should see "Three" for list item 3

  Scenario: Ordered List nested in another Ordered List
    When I get the outter ordered list
    Then I should see "One" for list item 1
    And I should see "Two" for list item 2
    And I should see "Three" for list item 3
