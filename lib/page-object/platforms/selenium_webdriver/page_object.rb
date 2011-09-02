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
        def alert(&block)
          @browser.execute_script "window.alert = function(msg) { window.__lastWatirAlert = msg; }"
          yield
          @browser.execute_script "return window.__lastWatirAlert"
        end

        #
        # platform method to handle a confirm popup
        # See PageObject#confirm
        #
        def confirm(response, &block)
          @browser.execute_script "window.confirm = function(msg) { window.__lastWatirConfirm = msg; return #{!!response} }"
          yield
          @browser.execute_script "return window.__lastWatirConfirm"
        end

        #
        # platform method to handle a prompt popup
        # See PageObject#prompt
        #
        def prompt(answer, &block)
          @browser.execute_script "window.prompt = function(text, value) { window.__lastWatirPrompt = { message: text, default_value: value }; return #{answer.to_json}; }"
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
          @browser.switch_to.default_content
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
          @browser.switch_to.default_content
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
          @browser.switch_to.default_content
        end

        #
        # platform method to get the text from a textarea
        # See PageObject::Accessors#text_area
        #
        def text_area_value_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::TextArea, 'textarea')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).attribute('value')
          @browser.switch_to.default_content
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
          @browser.switch_to.default_content
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
          @browser.switch_to.default_content
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
          @browser.switch_to.default_content
        end

        #
        # platform method to return the select list element
        # See PageObject::Accessors#select_list
        #
        def select_list_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::SelectList, 'select')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content
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
          @browser.switch_to.default_content
        end

        #
        # platform method to uncheck a checkbox
        # See PageObject::Accessors#checkbox
        #
        def uncheck_checkbox(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::CheckBox, 'input', :type => 'checkbox')
          switch_to_frame(frame_identifiers)
          @browser.find_element(how, what).click if @browser.find_element(how, what).selected?
          @browser.switch_to.default_content
        end

        #
        # platform method to determine if a checkbox is checked
        # See PageObject::Accessors#checkbox
        #
        def checkbox_checked?(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::CheckBox, 'input', :type => 'checkbox')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).selected?
          @browser.switch_to.default_content
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
          @browser.switch_to.default_content
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
          @browser.switch_to.default_content
        end

        #
        # platform method to clear a radio button
        # See PageObject::Accessors#radio_button
        #
        def clear_radio(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::RadioButton, 'input', :type => 'radio')
          switch_to_frame(frame_identifiers)
          @browser.find_element(how, what).click if @browser.find_element(how, what).selected?
          @browser.switch_to.default_content
        end

        #
        # platform method to determine if a radio button is selected
        # See PageObject::Accessors#radio_button
        #
        def radio_selected?(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::RadioButton, 'input', :type => 'radio')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).selected?
          @browser.switch_to.default_content
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
          @browser.switch_to.default_content
          Object::PageObject::Elements::RadioButton.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to return the text for a div
        # See PageObject::Accessors#div
        #
        def div_text_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Div, 'div')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).text
          @browser.switch_to.default_content
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
          @browser.switch_to.default_content
          Object::PageObject::Elements::Div.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to return the text for a span
        # See PageObject::Accessors#span
        #
        def span_text_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Span, 'span')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).text
          @browser.switch_to.default_content
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
          @browser.switch_to.default_content
          Object::PageObject::Elements::Span.new(element, :platform => :selenium_webdriver)
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
          Object::PageObject::Elements::Button.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve a table element
        # See PageObject::Accessors#table
        #
        def table_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Table, 'table')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content
          Object::PageObject::Elements::Table.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve the text from a table cell
        # See PageObject::Accessors#cell
        #
        def cell_text_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::TableCell, 'td')
          switch_to_frame(frame_identifiers)
          value = @browser.find_element(how, what).text
          @browser.switch_to.default_content
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
          @browser.switch_to.default_content
          Object::PageObject::Elements::TableCell.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve an image element
        # See PageObject::Accessors#image
        #
        def image_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Image, 'img')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content
          Object::PageObject::Elements::Image.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve a form element
        # See PageObject::Accessors#form
        #
        def form_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Form, 'form')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content
          Object::PageObject::Elements::Form.new(element, :platform => :selenium_webdriver)
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
          @browser.switch_to.default_content
          Object::PageObject::Elements::ListItem.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve an unordered list element
        # See PageObject::Accessors#unordered_list
        #
        def unordered_list_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::UnorderedList, 'ul')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content
          Object::PageObject::Elements::UnorderedList.new(element, :platform => :selenium_webdriver)
        end

        #
        # platform method to retrieve an ordered list element
        # See PageObject::Accessors#ordered_list
        #
        def ordered_list_for(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::OrderedList, 'ol')
          switch_to_frame(frame_identifiers)
          element = @browser.find_element(how, what)
          @browser.switch_to.default_content
          Object::PageObject::Elements::OrderedList.new(element, :platform => :selenium_webdriver)
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
          return false if identifier[:text] and tag == 'input' and additional[:type] == 'hidden'
          return false if identifier[:href] and tag == 'a'
          return false if identifier[:text] and ['div', 'span', 'td'].include? tag
          return false if identifier[:value] and tag == 'input' and additional[:type] == 'submit'
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
