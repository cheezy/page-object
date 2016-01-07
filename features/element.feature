Feature: Elements

  Background:
    Given I am on the static elements page

  Scenario: Clear an element
    When I type "abcDEF" into the text field
    Then the text field should contain "abcDEF"
    When I clear the text field
    Then the text field should contain ""

  Scenario: Elements enabled?
    When I check an enabled button
    Then it should know it is enabled
    And it should know that is it not disabled
    When I check a disabled button
    Then it should know it is not enabled
    And it should know that it is disabled
    
  Scenario: Setting focus and finding the element with focus
    When I set the focus to the test text_field
    Then I should know that the text_field has the focus

  Scenario: Link element methods
    When I retrieve a link element
    Then I should know it exists
    And I should know it is visible
    And I should know the text is "Google Search"
    And I should know the html is "<a href="success.html" id="link_id" name="link_name" class="link_class" title="link_title">Google Search</a>"
    And I should know it is equal to itself
    And I should know the tag name is "a"
    And I should know the attribute "readonly" is false
    And I should know the attribute "href" includes "success.html"
    And I should be able to click it

  @watir_only
  Scenario: Link element methods for watir
    When I retrieve a link element
    Then I should know the value is ""


  Scenario: Button element methods
    When I retrieve a button element
    Then I should know it exists
    And I should know it is visible
    And I should know the value is "Click Me"
    And I should know it is equal to itself
    And I should know the tag name is "input"
    And I should know the attribute "readonly" is false
    And I should be able to click it

  @watir_only
  Scenario: Button element methods for watir
    When I retrieve a button element
    Then I should know the text is "Click Me"

  Scenario: Check Box element methods
    When I retrieve a check box element
    Then I should know it exists
    And I should know it is visible
    And I should know the text is ""
    And I should know the value is "1"
    And I should know it is equal to itself
    And I should know the tag name is "input"
    And I should know the attribute "readonly" is false
    And I should be able to click it

  Scenario: Div element methods
    When I retrieve the div element
    Then I should know it exists
    And I should know it is visible
    And I should know the text is "page-object rocks!"
    And I should know it is equal to itself
    And I should know the tag name is "div"
    And I should know the attribute "readonly" is false
    And I should be able to click it

  @watir_only
  Scenario: Div element methods for watir
    When I retrieve the div element
    Then I should know the value is ""

  @selenium_only
  Scenario: Div element methods for selenium
    When I retrieve the div element
    Then I should know the value is nil

  Scenario: Radio Button element methods
    When I retrieve a radio button
    Then I should know it exists
    And I should know it is visible
    And I should know the text is ""
    And I should know the value is "Milk"
    And I should know it is equal to itself
    And I should know the tag name is "input"
    And I should know the attribute "readonly" is false
    And I should be able to click it

  Scenario: Select List element methods
    When I retrieve a select list
    Then I should know it exists
    And I should know it is visible
    And I should know the text includes "Test 1"
    And I should know the value is "option1"
    And I should know it is equal to itself
    And I should know the tag name is "select"
    And I should know the attribute "readonly" is false
    And I should be able to click it

  Scenario: Table element methods
    When I retrieve a table element
    Then I should know it is visible
    And I should know the text includes "Data1"
    And I should know it is equal to itself
    And I should know the tag name is "table"
    And I should know the attribute "readonly" is false
    And I should be able to click it

  @watir_only
  Scenario: Table element methods in watir
    When I retrieve a table element
    Then I should know it exists
    And I should know the value is ""

  @selenium_only
  Scenario: Table element methods in selenium
    When I retrieve a table element
    Then I should know the value is nil

  Scenario: Table Cell element methods
    When I retrieve table cell
    Then I should know it exists
    And I should know it is visible
    And I should know the text includes "Data4"
    And I should know it is equal to itself
    And I should know the tag name is "td"
    And I should know the attribute "readonly" is false
    And I should be able to click it

  @watir_only
  Scenario: Table Cell element methods in watir
    When I retrieve table cell
    Then I should know the value is ""

  @selenium_only
  Scenario: Table Cell element methods in selenium
    When I retrieve table cell
    Then I should know the value is nil

  Scenario: Text Field element methods
    When I retrieve a text field
    Then I should know it exists
    And I should know it is visible
    And I should know the text includes ""
    And I should know the value is ""
    And I should know it is equal to itself
    And I should know the tag name is "input"
    And I should know the attribute "readonly" is false
    And I should be able to click it

  Scenario: Text Area element methods
    When I retrieve the text area
    Then I should know it exists
    And I should know it is visible
    And I should know the text includes ""
    And I should know the value is ""
    And I should know it is equal to itself
    And I should know the tag name is "textarea"
    And I should know the attribute "readonly" is false
    And I should be able to click it

  Scenario: Image element methods
    When I get the image element
    Then I should know it exists
    And I should know it is visible
    And I should know the text includes ""
    And I should know it is equal to itself
    And I should know the tag name is "img"
    And I should know the attribute "readonly" is false
    And I should be able to click it

  @watir_only
  Scenario: Image element methods in watir
    When I get the image element
    Then I should know the value is ""

  @selenium_only
  Scenario: Image element methods in selenium
    When I get the image element
    Then I should know the value is nil

  Scenario: Hidden Field element methods
    When I retrieve the hidden field element
    Then I should know it exists
    And I should know it is not visible
    And I should know the text includes ""
    And I should know the value is "12345"
    And I should know it is equal to itself
    And I should know the tag name is "input"
    And I should know the attribute "readonly" is false

  Scenario: Form element methods
    When I locate the form
    Then I should know it exists
    And I should know it is visible
    And I should know the text includes ""
    And I should know it is equal to itself
    And I should know the tag name is "form"
    And I should know the attribute "readonly" is false

  @watir_only
  Scenario: Form element methods in watir
    When I locate the form
    Then I should know the value is ""

  @selenium_only
  Scenario: Form element methods in selenium
    When I locate the form
    Then I should know the value is nil

  Scenario: List item element methods
    When I retrieve a list item element
    Then I should know it exists
    And I should know it is visible
    And I should know the text is "Item One"
    And I should know it is equal to itself
    And I should know the tag name is "li"
    And I should know the attribute "readonly" is false
    And I should be able to click it

  Scenario: Unordered list element methods
    When I retrieve an unordered list element
    Then I should know it exists
    And I should know it is visible
    And I should know the text includes "Item One"
    And I should know the text includes "Item Two"
    And I should know the text includes "Item Three"
    And I should know it is equal to itself
    And I should know the tag name is "ul"
    And I should know the attribute "readonly" is false
    And I should be able to click it

  Scenario: Ordered list element methods
    When I retrieve an ordered list element
    Then I should know it exists
    And I should know it is visible
    And I should know the text includes "Number One"
    And I should know the text includes "Number Two"
    And I should know the text includes "Number Three"
    And I should know it is equal to itself
    And I should know the tag name is "ol"
    And I should know the attribute "readonly" is false
    And I should be able to click it

  Scenario: Heading element methods
    When I retrieve a heading element
    Then I should know it exists
    And I should know it is visible
    And I should know the text is "h1's are cool"
    And I should know it is equal to itself
    And I should know the tag name is "h1"
    And I should know the attribute "readonly" is false
    And I should be able to click it

  Scenario: Firing an event
    When I set the focus to the test text_field using the onfocus event
    Then I should see the onfocus text "changed by onfocus event"
    
  Scenario: Hovering over an element
    Given I am on the hover page
    When I hover over the hello link
    Then the font size should be "20px"
    
  Scenario: Setting focus on an element
    When I set the focus on the test text_field
    Then I should see the onfocus text "changed by onfocus event"

  Scenario: Finding a parent element
    When I find the child link element
    And ask for the parent element
    Then I should have a div parent

  Scenario: Flashing an element
    When I retrieve a button element
    Then I should be able to flash it
    
  Scenario: Getting an element's id
    When I retrieve a button element
    Then I should know its id is "button_id"

  Scenario: Double Clicking
    Given I am on the Double Click page
    When I double click the button
    Then the paragraph should read "Double Click Received"

  Scenario: Scrolling so an element is visible
    When I retrieve a heading element
    And I scroll the heading element into view
    Then the heading element should be visible

  @watir_only
  Scenario: Expanding how we find elements to include non-standard locators
    When I retrieve a div using data-entity
    Then I should know it exists
    And I should know it is visible
    And I should know the text is "found using data-entity"
    

  Scenario: Accessing an HTML 5 element using the declaration
    When I retrieve the figure using the declaration
    Then I should see the figure contains an image

  Scenario: Accessing an HTML 5 element using the element method
    When I retrieve the figure using the element
    Then I should see the figure contains an image

  Scenario: Getting the class name for an element
    When I search for the paragraph by "id"
    Then I should know the paragraph class is "p_class"

  Scenario: Selecting the text for an element
    Then I should be able to select "Elements" from the paragraph

  Scenario: Element location
    When I retrieve a link element
    Then I should be able to know its location

  Scenario: Element size
    When I retrieve a link element
    Then I should be able to know its size

  Scenario: Getting the height of an element
    When I retrieve a link element
    Then the element height is not 0

  Scenario: Getting the width of an element
    When I retrieve a link element
    Then the element width is not 0

  Scenario: Getting the centre of an element
    When I retrieve a button element
    Then the element centre should be greater than element y position
    And the element centre should be greater than element x position
