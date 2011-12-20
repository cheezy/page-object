require 'page-object/elements'
require 'page-object/core_ext/string'

module PageObject
  module Platforms
    module SeleniumWebDriver

      #
      # Selenium implementation of the page object platform driver.  You should not use the
      # class directly.  Instead you should include the PageObject module in your page object
      # and use the methods dynamically added from the PageObject::Accessors module.
      #
      class PageObject
        def initialize(browser)
          @browser = browser
        end

        #
        # platform method to navigate to a provided url
        # See PageObject#navigate_to
        #
        def navigate_to(url)
          @browser.navigate.to url
        end

        #
        # platform method to get the current url
        # See PageObject#current_url
        #
        def current_url
          @browser.current_url
        end

        #
        # platform method to retrieve the text from the current page
        # See PageObject#text
        #
        def text
          @browser.find_element(:tag_name, 'body').text
        end

        #
        # platform method to retrieve the html for the current page
        # See PageObject#html
        #
        def html
          @browser.page_source
        end

        #
        # platform method to retrieve the title for the current page
        # See PageObject#title
        #
        def title
          @browser.title
        end

        #
        # platform method to wait for a block to return true
        # See PageObject#wait_until
        #
        def wait_until(timeout, message = nil, &block)
          wait = ::Selenium::WebDriver::Wait.new({:timeout => timeout, :message => message})
          wait.until &block
        end

        #
        # platform method to handle an alert popup
        # See PageObject#alert
        #
        def alert(frame=nil, &block)
          @browser.execute_script "window.alert = function(msg) { window.__lastWatirAlert = msg; }"
          yield
          @browser.execute_script "return window.__lastWatirAlert"
        end

        #
        # platform method to handle a confirm popup
        # See PageObject#confirm
        #
        def confirm(response, frame=nil, &block)
          @browser.execute_script "window.confirm = function(msg) { window.__lastWatirConfirm = msg; return #{!!response} }"
          yield
          @browser.execute_script "return window.__lastWatirConfirm"
        end

        #
        # platform method to handle a prompt popup
        # See PageObject#prompt
        #
        def prompt(answer, frame=nil, &block)
          @browser.execute_script "window.prompt = function(text, value) { window.__lastWatirPrompt = { message: text, default_value: value }; return #{answer}; }"
          yield
          result = @browser.execute_script "return window.__lastWatirPrompt"
          result && result.dup.each_key { |k| result[k.to_sym] = result.delete(k) }
          result
        end
        
        #
        # platform method to handle attaching to a running window
        # See PageObject#attach_to_window
        #
        def attach_to_window(identifier, &block)
          value = identifier.values.first
          key = identifier.keys.first
          handles = @browser.window_handles
          handles.each do |handle|
            @browser.switch_to.window handle
            if (key == :title and value == @browser.title) or
              (key == :url and value == @browser.current_url)
              return @browser.switch_to.window handle, &block
            end
          end
        end

        #
        # platform method to switch to a frame and execute a block
        # See PageObject#in_frame
        #
        def in_frame(identifier, frame=nil, &block)
          switch_to_frame([identifier])
          block.call(nil)
          @browser.switch_to.default_content
        end
        
        #
        # platform method to refresh the page
        # See PageObject#refresh
        #
        def refresh
          @browser.navigate.refresh
        end

        #
        # platform method to go back to the previous page
        # See PageObject#back
        #
        def back
          @browser.navigate.back
        end

        #
        # platform method to go forward to the next page
        # See PageObject#forward
        #
        def forward
          @browser.navigate.forward
        end
        
        #
        # platform method to clear the cookies from the browser
        # See PageObject#clear_cookies
        #
        def clear_cookies
          @browser.manage.delete_all_cookies
        end
        
        #
        # platform method to save the current screenshot to a file
        # See PageObject#save_screenshot
        #
        def save_screenshot(file_name)
          @browser.save_screenshot(file_name)
        end

        #
        # platform method to get the value stored in a text field
        # See PageObject::Accessors#text_field
        #
        def text_field_value_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::TextField, 'input', :type => 'text')
          switch_to_frame(frame_identifiers)
          text = @browser.find_element(how, what).attribute('value')
          @browser.switch_to.default_content unless frame_identifiers.nil?
          text
        end

        #
        # platform method to set the value for a text field
        # See PageObject::Accessors#text_field
        #
        def text_field_value_set(identifier, value)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::TextField, 'input', :type => 'text')
          switch_to_frame(frame_identifiers)
          @browser.find_element(how, what).clear
          @browser.find_element(how, what).send_keys(value)
          @browser.switch_to.default_content unless frame_identifiers.nil?
        end

        #
        # platform method to retrieve a text field element
        # See PageObject::Accessors#text_field
        #
        def text_field_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::TextField, 'input', :type => 'text')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::TextField.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to get the value stored in a hidden field
        # See PageObject::Accessors#hidden_field
        #
        def hidden_field_value_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::HiddenField, 'input', :type => 'hidden')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).attribute('value')
          @browser.switch_to.default_content unless frame_identifiers.nil?
          value
        end

        #
        # platform method to retrieve a hidden field element
        # See PageObject::Accessors#hidden_field
        #
        def hidden_field_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::HiddenField, 'input', :type => 'hidden')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          Elements::HiddenField.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to set text in a textarea
        # See PageObject::Accessors#text_area
        #
        def text_area_value_set(identifier, value)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::TextArea, 'textarea')
          switch_to_frame(frame_identifiers)
          @browser.find_element(how, what).send_keys(value)
          @browser.switch_to.default_content unless frame_identifiers.nil?
        end

        #
        # platform method to get the text from a textarea
        # See PageObject::Accessors#text_area
        #
        def text_area_value_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::TextArea, 'textarea')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).attribute('value')
          @browser.switch_to.default_content unless frame_identifiers.nil?
          value
        end

        #
        # platform method to get the text area element
        # See PageObject::Accessors#text_area
        #
        def text_area_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::TextArea, 'textarea')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          Elements::TextArea.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to get the currently selected value from a select list
        # See PageObject::Accessors#select_list
        #
        def select_list_value_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::SelectList, 'select')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).attribute('value')
          @browser.switch_to.default_content unless frame_identifiers.nil?
          value
        end

        #
        # platform method to select a value from a select list
        # See PageObject::Accessors#select_list
        #
        def select_list_value_set(identifier, value)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::SelectList, 'select')
          switch_to_frame(frame_identifiers)
          @browser.find_element(how, what).send_keys(value)
          @browser.switch_to.default_content unless frame_identifiers.nil?
        end

        #
        # platform method to return the select list element
        # See PageObject::Accessors#select_list
        #
        def select_list_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::SelectList, 'select')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          Elements::SelectList.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to click a link
        # See PageObject::Accessors#link
        #
        def click_link_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Link, 'a')
          switch_to_frame frame_identifiers
          @browser.find_element(how, what).click
          @browser.switch_to.default_content unless frame_identifiers.nil?
        end

        #
        # platform method to return a PageObject::Elements::Link object
        # see PageObject::Accessors#link
        #
        def link_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Link, 'a')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          Elements::Link.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to check a checkbox
        # See PageObject::Accessors#checkbox
        #
        def check_checkbox(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::CheckBox, 'input', :type => 'checkbox')
          switch_to_frame(frame_identifiers)
          @browser.find_element(how, what).click unless @browser.find_element(how, what).selected?
          @browser.switch_to.default_content unless frame_identifiers.nil?
        end

        #
        # platform method to uncheck a checkbox
        # See PageObject::Accessors#checkbox
        #
        def uncheck_checkbox(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::CheckBox, 'input', :type => 'checkbox')
          switch_to_frame(frame_identifiers)
          @browser.find_element(how, what).click if @browser.find_element(how, what).selected?
          @browser.switch_to.default_content unless frame_identifiers.nil?
        end

        #
        # platform method to determine if a checkbox is checked
        # See PageObject::Accessors#checkbox
        #
        def checkbox_checked?(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::CheckBox, 'input', :type => 'checkbox')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).selected?
          @browser.switch_to.default_content unless frame_identifiers.nil?
          value
        end

        #
        # platform method to return a PageObject::Elements::CheckBox element
        # See PageObject::Accessors#checkbox
        #
        def checkbox_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::CheckBox, 'input', :type => 'checkbox')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          Elements::CheckBox.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to select a radio button
        # See PageObject::Accessors#radio_button
        #
        def select_radio(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::RadioButton, 'input', :type => 'radio')
          switch_to_frame(frame_identifiers)
          @browser.find_element(how, what).click unless @browser.find_element(how, what).selected?
          @browser.switch_to.default_content unless frame_identifiers.nil?
        end

        #
        # platform method to clear a radio button
        # See PageObject::Accessors#radio_button
        #
        def clear_radio(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::RadioButton, 'input', :type => 'radio')
          switch_to_frame(frame_identifiers)
          @browser.find_element(how, what).click if @browser.find_element(how, what).selected?
          @browser.switch_to.default_content unless frame_identifiers.nil?
        end

        #
        # platform method to determine if a radio button is selected
        # See PageObject::Accessors#radio_button
        #
        def radio_selected?(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::RadioButton, 'input', :type => 'radio')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).selected?
          @browser.switch_to.default_content unless frame_identifiers.nil?
          value
        end

        #
        # platform method to return a PageObject::Eements::RadioButton element
        # See PageObject::Accessors#radio_button
        #
        def radio_button_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::RadioButton, 'input', :type => 'radio')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::RadioButton.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to return the text for a div
        # See PageObject::Accessors#div
        #
        def div_text_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Div, 'div')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).text
          @browser.switch_to.default_content unless frame_identifiers.nil?
          value
        end

        #
        # platform method to return a PageObject::Elements::Div element
        # See PageObject::Accessors#div
        #
        def div_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Div, 'div')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::Div.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to return the text for a span
        # See PageObject::Accessors#span
        #
        def span_text_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Span, 'span')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).text
          @browser.switch_to.default_content unless frame_identifiers.nil?
          value
        end

        #
        # platform method to return a PageObject::Elements::Span element
        # See PageObject::Accessors#span
        #
        def span_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Span, 'span')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::Span.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to click a button
        # See PageObject::Accessors#button
        #
        def click_button_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Button, 'input', :type => 'submit')
          switch_to_frame(frame_identifiers)
          @browser.find_element(how, what).click
          @browser.switch_to.default_content unless frame_identifiers.nil?
        end

        #
        # platform method to retrieve a button element
        # See PageObject::Accessors#button
        #
        def button_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Button, 'input', :type => 'submit')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::Button.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve a table element
        # See PageObject::Accessors#table
        #
        def table_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Table, 'table')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::Table.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve the text from a table cell
        # See PageObject::Accessors#cell
        #
        def cell_text_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::TableCell, 'td')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).text
          @browser.switch_to.default_content unless frame_identifiers.nil?
          value
        end

        #
        # platform method to retrieve a table cell element
        # See PageObject::Accessors#cell
        #
        def cell_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::TableCell, 'td')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::TableCell.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve an image element
        # See PageObject::Accessors#image
        #
        def image_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Image, 'img')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::Image.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve a form element
        # See PageObject::Accessors#form
        #
        def form_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Form, 'form')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::Form.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve the text from a list item
        # See PageObject::Accessors#list_item
        #
        def list_item_text_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::ListItem, 'li')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).text
          @browser.switch_to.default_content
          value
        end

        #
        # platform method to retrieve a list item element
        # See PageObject::Accessors#list_item
        #
        def list_item_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::ListItem, 'li')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::ListItem.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve an unordered list element
        # See PageObject::Accessors#unordered_list
        #
        def unordered_list_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::UnorderedList, 'ul')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::UnorderedList.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve an ordered list element
        # See PageObject::Accessors#ordered_list
        #
        def ordered_list_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::OrderedList, 'ol')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::OrderedList.new(element, :platform => :selenium_webdriver)
        end
        
        #
        # platform method to retrieve the text from a h1
        # See PageObject::Accessors#h1
        #
        def h1_text_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h1')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).text
          @browser.switch_to.default_content
          value          
        end
        
        #
        # platform method to retrieve the h1 element
        # See PageObject::Accessors#h1
        #
        def h1_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h1')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::Heading.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve the text from a h2
        # See PageObject::Accessors#h2
        #
        def h2_text_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h2')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).text
          @browser.switch_to.default_content
          value          
        end
        
        #
        # platform method to retrieve the h2 element
        # See PageObject::Accessors#h2
        #
        def h2_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h2')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::Heading.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve the text from a h3
        # See PageObject::Accessors#h3
        #
        def h3_text_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h3')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).text
          @browser.switch_to.default_content
          value          
        end
        
        #
        # platform method to retrieve the h3 element
        # See PageObject::Accessors#h3
        #
        def h3_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h3')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::Heading.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve the text from a h4
        # See PageObject::Accessors#h4
        #
        def h4_text_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h4')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).text
          @browser.switch_to.default_content
          value          
        end
        
        #
        # platform method to retrieve the h4 element
        # See PageObject::Accessors#h4
        #
        def h4_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h4')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::Heading.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve the text from a h5
        # See PageObject::Accessors#h5
        #
        def h5_text_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h5')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).text
          @browser.switch_to.default_content
          value          
        end
        
        #
        # platform method to retrieve the h5 element
        # See PageObject::Accessors#h5
        #
        def h5_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h5')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::Heading.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve the text from a h6
        # See PageObject::Accessors#h6
        #
        def h6_text_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h6')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).text
          @browser.switch_to.default_content
          value          
        end
        
        #
        # platform method to retrieve the h6 element
        # See PageObject::Accessors#h6
        #
        def h6_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h6')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::Heading.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve the text for a paragraph
        # See PageObject::Accessors#paragraph
        #
        def paragraph_text_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Paragraph, 'p')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).text
          @browser.switch_to.default_content unless frame_identifiers.nil?
          value          
        end
        
        #
        # platform method to retrieve the paragraph element
        # See PageObject::Accessors#paragraph
        #
        def paragraph_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'p')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::Paragraph.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to set the file on a file_field element
        # See PageObject::Accessors#file_field
        #
        def file_field_value_set(identifier, value)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::FileField, 'input', :type => 'file')
          switch_to_frame(frame_identifiers)
          @browser.find_element(how, what).send_keys(value)
          @browser.switch_to.default_content unless frame_identifiers.nil?
        end

        #
        # platform method to retrieve a file_field element
        # See PageObject::Accessors#file_field
        #
        def file_field_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::FileField, 'input', :type => 'file')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content unless frame_identifiers.nil?
          ::PageObject::Elements::FileField.new(element, :platform => :selenium_webdriver)
        end

        private
        
        def parse_identifiers(identifier, element, tag_name=nil, additional=nil)
          frame_identifiers = identifier.delete(:frame)
          identifier = add_tagname_if_needed identifier, tag_name, additional if tag_name
          how, what = element.selenium_identifier_for identifier
          return how, what, frame_identifiers
        end

        def add_tagname_if_needed identifier, tag, additional=nil
          return identifier if identifier.length < 2 and supported_identifier(identifier, tag, additional)
          identifier[:tag_name] = tag
          if additional
            additional.each do |key, value|
              identifier[key] = value
            end
          end
          identifier
        end

        def supported_identifier(identifier, tag, additional)
          return false if identifier[:index]
          return false if identifier[:action] and tag == 'form'
          return false if identifier[:alt] and tag == 'img'
          return false if identifier[:alt] and tag == 'input' and additional[:type] == 'submit'
          return false if identifier[:href] and tag == 'a'
          return false if identifier[:src] and tag == 'input' and additional[:type] == 'submit'
          return false if identifier[:src] and tag == 'img'
          return false if identifier[:text] and tag == 'input' and additional[:type] == 'hidden'
          return false if identifier[:text] and ['div', 'span', 'td'].include? tag
          return false if identifier[:title] and tag == 'input' and additional[:type] == 'text'
          return false if identifier[:title] and tag == 'input' and additional[:type] == 'file'
          return false if identifier[:value] and tag == 'input' and ['radio', 'submit', 'checkbox', 'hidden'].include? additional[:type]
          true
        end

        def switch_to_frame(frame_identifiers)
          unless frame_identifiers.nil?
            frame_identifiers.each do |frame_id|
              value = frame_id.values.first
              @browser.switch_to.frame(value)
            end
          end          
        end
      end
    end
  end
end
