Feature: Sections

  Background:
    Given I am on the section elements page

  Scenario: Getting the text from a section
    When I get the text from the section
    Then the text should include "page-object rocks!"

  Scenario: Cannot find elements not in the section
    When I access an element that is outside of the section
    Then I should see that it doesn't exist in the section

  Scenario: Finding a link within a section
    When I search for a link located in a section
    Then I should be able to click the section link

  Scenario: Finding a button within a section
    When I search for a button located in a section
    Then I should be able to click the section button

  Scenario: Finding a text field within a section
    When I search for a text field located in a section
    Then I should be able to type "123abc" in the section text field

  Scenario: Finding a hidden field within a section
    When I search for a hidden field located in a section
    Then I should be able to see that the section hidden field contains "LeanDog"

  Scenario: Finding a text area within a section
    When I search for a text area located in a section
    Then I should be able to type "abcdefg" in the section text area

  Scenario: Finding a select list within a section
    When I search for a select list located in a section
    Then I should be able to select "Test 2" in the section select list

  Scenario: Finding a file field within a section
    When I search for a file field located in a section
    Then I should be able to set the section file field

  Scenario: Finding a checkbox within a section
    When I search for a checkbox located in a section
    Then I should be able to check the section checkbox

  Scenario: Finding a radio button witin a section
    When I search for a radio button located in a section
    Then I should be able to select the section radio button

  Scenario: Finding a div within a section
    When I search for a div located in a section
    Then I should see the text "page-object rocks!" in the section div

  Scenario: Finding a span within a section
    When I search for a span located in a section
    Then I should see the text "My alert" in the section span

  Scenario: Finding a table within a section
    When I search for a table located in a section
    Then the data for row "1" of the section table should be "Data1" and "Data2"

  Scenario: Finding a table cell within a section
    When I search the second table cell located in a table in a section
    Then the section table cell should contain "Data2"

  Scenario: Finding an image within a section
    When I search for an image located in a section
    Then the section image should be "106" pixels wide
    And the section image should be "106" pixels tall

  Scenario: Finding a form within a section
    When I search for a form located in a section
    Then I should be able to submit the section form

  Scenario: Finding an ordered list within a section
    When I search for an ordered list located in a section
    Then the first section list items text should be "Number One"

  Scenario: Finding an unordered list within a section
    When I search for an unordered list located in a section
    Then the first section list items text should be "Item One"

  Scenario: Finding a list item section in an ordered list within a section
    When I search for a list item section in an ordered list in a section
    Then I should see the section list items text should be "Number One"

  Scenario: Finding a h1 within a section
    When I search for a h1 located in a section
    Then I should see the section h1s text should be "h1's are cool"

  Scenario: Finding a h2 within a section
    When I search for a h2 located in a section
    Then I should see the section h2s text should be "h2's are cool"

  Scenario: Finding a h3 within a section
    When I search for a h3 located in a section
    Then I should see the section h3s text should be "h3's are cool"

  Scenario: Finding a h4 within a section
    When I search for a h4 located in a section
    Then I should see the section h4s text should be "h4's are cool"

  Scenario: Finding a h5 within a section
    When I search for a h5 located in a section
    Then I should see the section h5s text should be "h5's are cool"

  Scenario: Finding a h6 within a section
    When I search for a h6 located in a section
    Then I should see the section h6s text should be "h6's are cool"

  Scenario: Finding a paragraph within a section
    When I search for a paragraph located in a section
    Then I should see the section paragraphs text should be "This is a paragraph."

  Scenario: Indexed property in section
    Given I search for a link in an indexed property located in a section
    Then I should see the text "Success" in the section indexed link

  Scenario: Sections roots can be accessed
    When I have a page section
    Then methods called on the section are passed to the root if missing

  Scenario: Selecting multiple sections
    When I select multiple sections
    Then I should have a section collection containing the sections
    And I can access any index of that collection of sections

  Scenario: Searching section collection
    Given I select multiple sections
    When I search by a specific value of the section
    Then I will find the first section with that value

  Scenario: Filtering section collection
    Given I select multiple sections
    When I filter by a specific value of the sections
    Then I will find all sections with that value
