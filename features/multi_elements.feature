Feature: Multi Elements

  Background:
    Given I am on the multi elements page

  Scenario: Selecting buttons using an identifier
    When I select the buttons with class "button"
    Then I should have 3 buttons
    And the value of button 1 should be "Button 1"
    And the value of button 2 should be "Button 2"
    And the value of button 3 should be "Button 3"

  Scenario: Selecting buttons using no identifier
    When I select all buttons using no identifier
    Then I should have 3 buttons

  Scenario: Selecting text fields using an identifier
    When I select the text fields with class "textfield"
    Then I should have 3 text fields
    And the value of text field 1 should be "text 1"
    And the value of text field 2 should be "text 2"
    And the value of text field 3 should be "text 3"

  Scenario: Selecting text fields using no identifier
    When I select all text fields using no identifier
    Then I should have 3 text fields

  Scenario: Selecting hidden fields using an identifier
    When I select the hidden fields with class "hiddenfield"
    Then I should have 3 hidden fields
    And the value of hidden field 1 should be "hidden 1"
    And the value of hidden field 2 should be "hidden 2"
    And the value of hidden field 3 should be "hidden 3"

  Scenario: Selecting hidden fields using no identifier
    When I select all hidden fields using no identifier
    Then I should have 3 hidden fields

  Scenario: Selecting text areas using an identifier
    When I select the text areas with class "textarea"
    Then I should have 3 text areas
    And the value of text area 1 should be "textarea 1"
    And the value of text area 2 should be "textarea 2"
    And the value of text area 3 should be "textarea 3"

  Scenario: Selecting text areas using no identifier
    When I select text areas using no identifier
    Then I should have 3 text areas

  Scenario: Selecting select lists using an identifier
    When I select the select lists with class "selectlist"
    Then I should have 3 select lists
    And the value of select list 1 should be "selectlist 1"
    And the value of select list 2 should be "selectlist 2"
    And the value of select list 3 should be "selectlist 3"

  Scenario: Selecting select lists using no identifier
    When I select select lists using no identifier
    Then I should have 3 select lists

  Scenario: Selecting links using an identifier
    When I select the link with class "link"
    Then I should have 3 links
    And the text of link 1 should be "link 1"
    And the text of link 2 should be "link 2"
    And the text of link 3 should be "link 3"

  Scenario: Selecting links using no identifier
    When I select links using no identifier
    Then I should have 3 links

  Scenario: Selecting checkboxes using an identifier
    When I select the check boxes with class "checkbox"
    Then I should have 3 checkboxes
    And the value of checkbox 1 should be "checkbox 1"
    And the value of checkbox 2 should be "checkbox 2"
    And the value of checkbox 3 should be "checkbox 3"

  Scenario: Selecting checkboxes using no identifier
    When I select checboxes using no identifier
    Then I should have 3 checkboxes

  Scenario: Selecting radio buttons using an identifier
    When I select the radio button with class "radio"
    Then I should have 3 radio buttons
    And the value of radio button 1 should be "radio 1"
    And the value of radio button 2 should be "radio 2"
    And the value of radio button 3 should be "radio 3"

  Scenario: Selecting radio buttons using no identifier
    When I select radio buttons using no identifier
    Then I should have 3 radio buttons

  Scenario: Selecting divs using an identifier
    When I select the div with class "div"
    Then I should have 3 divs
    And the text of div 1 should be "Div 1"
    And the text of div 2 should be "Div 2"
    And the text of div 3 should be "Div 3"

  Scenario: Selecting divs using no identifier
    When I select divs using no identifier
    Then I should have 3 divs

  Scenario: Selecting spans using an identifier
    When I select the spans with class "span"
    Then I should have 3 spans
    And the text of span 1 should be "Span 1"
    And the text of span 2 should be "Span 2"
    And the text of span 3 should be "Span 3"

  Scenario: Selecting spans using no identifier
    When I select spans using no identifier
    Then I should have 3 spans

  Scenario: Selecting tables using an identifier
    When I select the tables with class "table"
    Then I should have 3 tables
    And the first row first column for table 1 should have "Data 1"
    And the first row first column for table 2 should have "Data 4"
    And the first row first column for table 3 should have "Data 7"

  Scenario: Selecting tables using no identifier
    When I select tables using no identifier
    Then I should have 3 tables

  Scenario: Selecting cells using an identifier
    When I select the cells with class "td"
    Then I should have 3 cells
    And the text for cell 1 should be "Data 1"
    And the text for cell 2 should be "Data 2"
    And the text for cell 3 should be "Data 3"

  Scenario: Selecting cells using no identifier
    When I select the cells using no identifier
    Then I should have 9 cells

  Scenario: Selecting images using an identifier
    When I select the images with class "image"
    Then I should have 3 images
    And the alt for image 1 should be "image 1"
    And the alt for image 2 should be "image 2"
    And the alt for image 3 should be "image 3"

  Scenario: Selecting images using no identifier
    When I select the images using no identifier
    Then I should have 3 images

  Scenario: Selecting forms using an identifier
    When I select the forms with class "form"
    Then I should have 3 forms
    And the action for form 1 should be "form1"
    And the action for form 2 should be "form2"
    And the action for form 3 should be "form3"

  Scenario: Selecting forms using no identifier
    When I select the forms using no identifier
    Then I should have 3 forms

  Scenario: Selecting list items using an identifier
    When I select the list items with class "li"
    Then I should have 3 list items
    And the text for list item 1 should be "Item One"
    And the text for list item 2 should be "Item Two"
    And the text for list item 3 should be "Item Three"

  Scenario: Selecting list items using no identifier
    When I select the list items using no identifier
    Then I should have 8 list items

  Scenario: Selecting unordered lists using an identifier
    When I select the unordered list with class "ul"
    Then I should have 3 unordered lists
    And the text for the first item in unordered list 1 should be "Item One"
    And the text for the first item in unordered list 2 should be "Item Four"
    And the text for the first item in unordered list 3 should be "Item Five"

  Scenario: Selecting unordered lists using no identifier
    When I select the unordered list using no parameter
    Then I should have 3 unordered lists

  Scenario: Selecting ordered lists using an identifier
    When I select the ordered lists with class "ol"
    Then I should have 3 ordered lists
    And the text for the first item in ordered list 1 should be "Number One"
    And the text for the first item in ordered list 2 should be "Number Two"
    And the text for the first item in ordered list 3 should be "Number Three"

  Scenario: Selecting ordered lists using no identifier
    When I select the ordered lists using no identifier
    Then I should have 3 ordered lists

  Scenario: Selecting h1s using an identifier
    When I select the h1s with class "h1"
    Then I should have 3 h1s
    And the text for h1 1 should be "H1 One"
    And the text for h1 2 should be "H1 Two"
    And the text for h1 3 should be "H1 Three"

  Scenario: Selecting h1s using no identifier
    When I select h1s using no identifier
    Then I should have 3 h1s

  Scenario: Selecting h2s using an identifier
    When I select the h2s with the class "h2"
    Then I should have 3 h2s
    And the text for h2 1 should be "H2 One"
    And the text for h2 2 should be "H2 Two"
    And the text for h2 3 should be "H2 Three"

  Scenario: Selecting h2s using no identifier
    When I select h2s using no identifier
    Then I should have 3 h2s

  Scenario: Selecting h3s using an identifier
    When I select the h3s with the class "h3"
    Then I should have 3 h3s
    And the text for h3 1 should be "H3 One"
    And the text for h3 2 should be "H3 Two"
    And the text for h3 3 should be "H3 Three"

  Scenario: Selecting h3s using no identifier
    When I select h3s using no identifier
    Then I should have 3 h3s

  Scenario: Selecting h4s using an identifier
    When I select the h4s with the class "h4"
    Then I should have 3 h4s
    And the text for H4 1 should be "H4 One"
    And the text for H4 2 should be "H4 Two"
    And the text for H4 3 should be "H4 Three"

  Scenario: Selecting h4s using no identifier
    When I select h4s using no identifier
    Then I should have 3 h4s

  Scenario: Selecting h5s using an identifier
    When I select the h5s with the class "h5"
    Then I should have 3 h5s
    And the text for H5 1 should be "H5 One"
    And the text for H5 2 should be "H5 Two"
    And the text for H5 3 should be "H5 Three"

  Scenario: Selecting h5s using no identifier
    When I select h5s using no identifier
    Then I should have 3 h5s

  Scenario: Selecting h6s using an identifier
    When I select the h6s with the class "h6"
    Then I should have 3 h6s
    And the text for H6 1 should be "H6 One"
    And the text for H6 2 should be "H6 Two"
    And the text for H6 3 should be "H6 Three"

  Scenario: Selecting h6s using no identifier
    When I select h6s using no identifier
    Then I should have 3 h6s

  Scenario: Selecting paragraphs using an identifier
    When I select the paragraph with class "p"
    Then I should have 3 paragraphs
    And the text for paragraph 1 should be "Paragraph One"
    And the text for paragraph 2 should be "Paragraph Two"
    And the text for paragraph 3 should be "Paragraph Three"

  Scenario: Selecting paragraphs using no identifier
    When I select paragraphs using no identifier
    Then I should have 3 paragraphs

  Scenario: Selecting labels with an identifier
    When I select the labels with class "label"
    Then I should have 3 labels
    And the text for label 1 should be "Label 1"
    And the text for label 2 should be "Label 2"
    And the text for label 3 should be "Label 3"

  Scenario: Selecting labels using no identifier
    When I select labels using no identifier
    Then I should have 3 labels

  Scenario: Selecting file fields with an identifier
    When I select the file fields with class "file_field_class"
    Then I should have 3 file fields
    And the title for file field 1 should be "File Field 1"
    And the title for file field 2 should be "File Field 2"
    And the title for file field 3 should be "File Field 3"

  Scenario: Selecting file fields using no identifier
    When I select the file fields using no identifier
    Then I should have 3 file fields

  Scenario: Selecting all divs based on a class declaration
    When I select the divs using the generated method
    Then I should have 3 divs
    And the text of div 1 should be "Div 1"
    And the text of div 2 should be "Div 2"
    And the text of div 3 should be "Div 3"

  Scenario: Selecting all divs using a block instead of an identifier
    When I select the divs using a block
    Then I should have 3 divs
    And the text of div 1 should be "Div 1"
    And the text of div 2 should be "Div 2"
    And the text of div 3 should be "Div 3"

  Scenario: Selecting buttons based on a class declaration
    When I select the buttons using the generated method
    Then I should have 3 buttons
    And the value of button 1 should be "Button 1"
    And the value of button 2 should be "Button 2"
    And the value of button 3 should be "Button 3"

  Scenario: Selecting text fields based on a class declaration
    When I select the text fields using the generated method
    Then I should have 3 text fields
    And the value of text field 1 should be "text 1"
    And the value of text field 2 should be "text 2"
    And the value of text field 3 should be "text 3"

  Scenario: Selecting hidden fields based on a class declaration
    When I select the hidden fields using the generated method
    Then I should have 3 hidden fields
    And the value of hidden field 1 should be "hidden 1"
    And the value of hidden field 2 should be "hidden 2"
    And the value of hidden field 3 should be "hidden 3"

  Scenario: Selecting text areas based on a class declaration
    When I select the text areas using the generated method
    Then I should have 3 text areas
    And the value of text area 1 should be "textarea 1"
    And the value of text area 2 should be "textarea 2"
    And the value of text area 3 should be "textarea 3"

  Scenario: Selecting select lists based on a class declaration
    When I select the select lists using the generated method
    Then I should have 3 select lists
    And the value of select list 1 should be "selectlist 1"
    And the value of select list 2 should be "selectlist 2"
    And the value of select list 3 should be "selectlist 3"

  Scenario: Selecting links based on a class declaration
    When I select the link using the generated method
    Then I should have 3 links
    And the text of link 1 should be "link 1"
    And the text of link 2 should be "link 2"
    And the text of link 3 should be "link 3"

  Scenario: Selecting checkboxes based on a class declaration
    When I select the check boxes using the generated method
    Then I should have 3 checkboxes
    And the value of checkbox 1 should be "checkbox 1"
    And the value of checkbox 2 should be "checkbox 2"
    And the value of checkbox 3 should be "checkbox 3"

  Scenario: Selecting radio buttons based on a class declaration
    When I select the radio button using the generated method
    Then I should have 3 radio buttons
    And the value of radio button 1 should be "radio 1"
    And the value of radio button 2 should be "radio 2"
    And the value of radio button 3 should be "radio 3"

  Scenario: Selecting spans based on a class declaration
    When I select the spans using the generated method
    Then I should have 3 spans
    And the text of span 1 should be "Span 1"
    And the text of span 2 should be "Span 2"
    And the text of span 3 should be "Span 3"

  Scenario: Selecting tables based on a class declaration
    When I select the tables using the generated method
    Then I should have 3 tables
    And the first row first column for table 1 should have "Data 1"
    And the first row first column for table 2 should have "Data 4"
    And the first row first column for table 3 should have "Data 7"

  Scenario: Selecting cells based on a class declaration
    When I select the cells using the generated method
    Then I should have 3 cells
    And the text for cell 1 should be "Data 1"
    And the text for cell 2 should be "Data 2"
    And the text for cell 3 should be "Data 3"

  Scenario: Selecting images based on a class declaration
    When I select the images using the generated method
    Then I should have 3 images
    And the alt for image 1 should be "image 1"
    And the alt for image 2 should be "image 2"
    And the alt for image 3 should be "image 3"

  Scenario: Selecting forms based on a class declaration
    When I select the forms using the generated method
    Then I should have 3 forms
    And the action for form 1 should be "form1"
    And the action for form 2 should be "form2"
    And the action for form 3 should be "form3"

  Scenario: Selecting list items based on a class declaration
    When I select the list items using the generated method
    Then I should have 3 list items
    And the text for list item 1 should be "Item One"
    And the text for list item 2 should be "Item Two"
    And the text for list item 3 should be "Item Three"

  Scenario: Selecting unordered lists based on a class declaration
    When I select the unordered list using the generated method
    Then I should have 3 unordered lists
    And the text for the first item in unordered list 1 should be "Item One"
    And the text for the first item in unordered list 2 should be "Item Four"
    And the text for the first item in unordered list 3 should be "Item Five"

  Scenario: Selecting ordered lists based on a class declaration
    When I select the ordered lists using the generated method
    Then I should have 3 ordered lists
    And the text for the first item in ordered list 1 should be "Number One"
    And the text for the first item in ordered list 2 should be "Number Two"
    And the text for the first item in ordered list 3 should be "Number Three"

  Scenario: Selecting h1s based on a class declaration
    When I select the h1s using the generated method
    Then I should have 3 h1s
    And the text for h1 1 should be "H1 One"
    And the text for h1 2 should be "H1 Two"
    And the text for h1 3 should be "H1 Three"

  Scenario: Selecting h2s based on a class declaration
    When I select the h2s using the generated method
    Then I should have 3 h2s
    And the text for h2 1 should be "H2 One"
    And the text for h2 2 should be "H2 Two"
    And the text for h2 3 should be "H2 Three"

  Scenario: Selecting h3s based on a class declaration
    When I select the h3s using the generated method
    Then I should have 3 h3s
    And the text for h3 1 should be "H3 One"
    And the text for h3 2 should be "H3 Two"
    And the text for h3 3 should be "H3 Three"

  Scenario: Selecting h4s based on a class declaration
    When I select the h4s using the generated method
    Then I should have 3 h4s
    And the text for H4 1 should be "H4 One"
    And the text for H4 2 should be "H4 Two"
    And the text for H4 3 should be "H4 Three"

  Scenario: Selecting h5s based on a class declaration
    When I select the h5s using the generated method
    Then I should have 3 h5s
    And the text for H5 1 should be "H5 One"
    And the text for H5 2 should be "H5 Two"
    And the text for H5 3 should be "H5 Three"

  Scenario: Selecting h6s based on a class declaration
    When I select the h6s using the generated method
    Then I should have 3 h6s
    And the text for H6 1 should be "H6 One"
    And the text for H6 2 should be "H6 Two"
    And the text for H6 3 should be "H6 Three"

  Scenario: Selecting paragraphs based on a class declaration
    When I select the paragraph using the generated method
    Then I should have 3 paragraphs
    And the text for paragraph 1 should be "Paragraph One"
    And the text for paragraph 2 should be "Paragraph Two"
    And the text for paragraph 3 should be "Paragraph Three"

  Scenario: Selecting labels based on a class declaration
    When I select the labels using the generated method
    Then I should have 3 labels
    And the text for label 1 should be "Label 1"
    And the text for label 2 should be "Label 2"
    And the text for label 3 should be "Label 3"

  Scenario: Selecting file fields based on a class declaration
    When I select the file fields using the generated method
    Then I should have 3 file fields
    And the title for file field 1 should be "File Field 1"
    And the title for file field 2 should be "File Field 2"
    And the title for file field 3 should be "File Field 3"

  Scenario: Selecting multple generic element types
    When I select the multiple elements with a tag label
    Then I should have 3 labels
    And the text for label 1 should be "Label 1"
    And the text for label 2 should be "Label 2"
    And the text for label 3 should be "Label 3"

  Scenario: Selecting bs using an identifier
    When I select the bs
    Then I should have 2 bs
    And the text for b 1 should be "One B"
    And the text for b 2 should be "Two B"

  Scenario: Selecting is using an identifier
    When I select the is
    Then I should have 2 is
    And the text for i 1 should be "One I"
    And the text for i 2 should be "Two I"