require 'watir-webdriver/extensions/alerts'
require 'page-object/elements'
require 'page-object/core_ext/string'


module PageObject
  module Platforms
    module WatirWebDriver
      #
      # Watir implementation of the page object platform driver.  You should not use the
      # class directly.  Instead you should include the PageObject module in your page object
      # and use the methods dynamically added from the PageObject::Accessors module.
      #
      class PageObject
        attr_reader :browser

        def initialize(browser)
          @browser = browser
        end

        #
        # platform method to navigate to a provided url
        # See PageObject#navigate_to
        #
        def navigate_to(url)
          @browser.goto url
        end
        
        #
        # platform method to get the current url
        # See PageObject#current_url
        #
        def current_url
          @browser.url
        end

        #
        # platform method to retrieve the text from the current page
        # See PageObject#text
        #
        def text
          @browser.text
        end

        #
        # platform method to retrieve the html for the current page
        # See PageObject#html
        #
        def html
          @browser.html
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
        def wait_until(timeout, message = nil, &block)
          @browser.wait_until(timeout, message, &block)
        end

        #
        # platform method to handle an alert popup
        # See PageObject#alert
        #
        def alert(&block)
          @browser.alert(&block)
        end

        #
        # platform method to handle a confirm popup
        # See PageObject#confirm
        #
        def confirm(response, &block)
          @browser.confirm(response, &block)
        end

        #
        # platform method to handle a prompt popup
        # See PageObject#prompt
        #
        def prompt(answer, &block)
          @browser.prompt(answer, &block)
        end
    
        #
        # platform method to handle attaching to a running window
        # See PageObject#attach_to_window
        #
        def attach_to_window(identifier, &block)
          win_id = {identifier.keys.first => /#{Regexp.escape(identifier.values.first)}/}
          @browser.window(win_id).use &block
        end
    
        #
        # platform method to refresh the page
        # See PageObject#refresh
        #
        def refresh
          @browser.refresh
        end
    
        #
        # platform method to go back to the previous page
        # See PageObject#back
        #
        def back
          @browser.back
        end
    
        #
        # platform method to go forward to the next page
        # See PageObject#forward
        #
        def forward
          @browser.forward
        end
        
        #
        # platform method to clear the cookies from the browser
        # See PageObject#clear_cookies
        #
        def clear_cookies
          @browser.clear_cookies
        end

        #
        # platform method to save the current screenshot to a file
        # See PageObject#save_screenshot
        #
        def save_screenshot(file_name)
          @browser.wd.save_screenshot(file_name)
        end

        #
        # platform method to get the value stored in a text field
        # See PageObject::Accessors#text_field
        #
        def text_field_value_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::TextField)
          @browser.instance_eval "#{nested_frames(frame_identifiers)}text_field(identifier).value"
        end

        #
        # platform method to set the value for a text field
        # See PageObject::Accessors#text_field
        #
        def text_field_value_set(identifier, value)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::TextField)
          @browser.instance_eval "#{nested_frames(frame_identifiers)}text_field(identifier).set(value)"
        end
    
        #
        # platform method to retrieve a text field element
        # See PageObject::Accessors#text_field
        #
        def text_field_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::TextField)
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}text_field(identifier)"
          Elements::TextField.new(element, :platform => :watir_webdriver)
        end

        #
        # platform method to get the value stored in a hidden field
        # See PageObject::Accessors#hidden_field
        #
        def hidden_field_value_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::HiddenField)
          @browser.instance_eval "#{nested_frames(frame_identifiers)}hidden(identifier).value"
        end

        #
        # platform method to retrieve a hidden field element
        # See PageObject::Accessors#hidden_field
        #
        def hidden_field_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::HiddenField)
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}hidden(identifier)"
          Elements::HiddenField.new(element, :platform => :watir_webdriver)
        end

        #
        # platform method to set text in a textarea
        # See PageObject::Accessors#text_area
        #
        def text_area_value_set(identifier, value)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::TextArea)
          @browser.instance_eval "#{nested_frames(frame_identifiers)}textarea(identifier).send_keys(value)"
        end

        #
        # platform method to get the text from a textarea
        # See PageObject::Accessors#text_area
        #
        def text_area_value_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::TextArea)
          @browser.instance_eval "#{nested_frames(frame_identifiers)}textarea(identifier).value"
        end

        #
        # platform method to get the text area element
        # See PageObject::Accessors#text_area
        #
        def text_area_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::TextArea)
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}textarea(identifier)"
          Elements::TextArea.new(element, :platform => :watir_webdriver)
        end

        #
        # platform method to get the currently selected value from a select list
        # See PageObject::Accessors#select_list
        #
        def select_list_value_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::SelectList)
          @browser.instance_eval "#{nested_frames(frame_identifiers)}select_list(identifier).value"
        end

        #
        # platform method to select a value from a select list
        # See PageObject::Accessors#select_list
        #
        def select_list_value_set(identifier, value)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::SelectList)
          @browser.instance_eval "#{nested_frames(frame_identifiers)}select_list(identifier).select(value)"
        end

        #
        # platform method to return the select list element
        # See PageObject::Accessors#select_list
        #
        def select_list_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::SelectList)
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}select_list(identifier)"
          Elements::SelectList.new(element, :platform => :watir_webdriver)
        end

        #
        # platform method to click a link
        # See PageObject::Accessors#link
        #
        def click_link_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Link)
          @browser.instance_eval "#{nested_frames(frame_identifiers)}link(identifier).click if identifier"
        end

        #
        # platform method to return a PageObject::Elements::Link object
        # see PageObject::Accessors#link
        #
        def link_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Link)
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}link(identifier)"
          Elements::Link.new(element, :platform => :watir_webdriver)
        end

        #
        # platform method to check a checkbox
        # See PageObject::Accessors#checkbox
        #
        def check_checkbox(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::CheckBox)
          @browser.instance_eval "#{nested_frames(frame_identifiers)}checkbox(identifier).set"
        end

        #
        # platform method to uncheck a checkbox
        # See PageObject::Accessors#checkbox
        #
        def uncheck_checkbox(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::CheckBox)
          @browser.instance_eval "#{nested_frames(frame_identifiers)}checkbox(identifier).clear"
        end

        #
        # platform method to determine if a checkbox is checked
        # See PageObject::Accessors#checkbox
        #
        def checkbox_checked?(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::CheckBox)
          @browser.instance_eval "#{nested_frames(frame_identifiers)}checkbox(identifier).set?"
        end

        #
        # platform method to return a PageObject::Elements::CheckBox element
        # See PageObject::Accessors#checkbox
        #
        def checkbox_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::CheckBox)
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}checkbox(identifier)"
          Elements::CheckBox.new(element, :platform => :watir_webdriver)
        end

        #
        # platform method to select a radio button
        # See PageObject::Accessors#radio_button
        #
        def select_radio(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::RadioButton)
          @browser.instance_eval "#{nested_frames(frame_identifiers)}radio(identifier).set"
        end

        #
        # platform method to clear a radio button
        # See PageObject::Accessors#radio_button
        #
        def clear_radio(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::RadioButton)
          @browser.instance_eval "#{nested_frames(frame_identifiers)}radio(identifier).clear"
        end

        #
        # platform method to determine if a radio button is selected
        # See PageObject::Accessors#radio_button
        #
        def radio_selected?(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::RadioButton)
          @browser.instance_eval "#{nested_frames(frame_identifiers)}radio(identifier).set?"
        end

        #
        # platform method to return a PageObject::Eements::RadioButton element
        # See PageObject::Accessors#radio_button
        #
        def radio_button_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::RadioButton)
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}radio(identifier)"
          Object::PageObject::Elements::RadioButton.new(element, :platform => :watir_webdriver)
        end

        #
        # platform method to return the text for a div
        # See PageObject::Accessors#div
        #
        def div_text_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Div, 'div')
          @browser.instance_eval "#{nested_frames(frame_identifiers)}div(identifier).text"
        end

        #
        # platform method to return a PageObject::Elements::Div element
        # See PageObject::Accessors#div
        #
        def div_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Div, 'div')
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}div(identifier)"
          Object::PageObject::Elements::Div.new(element, :platform => :watir_webdriver)
        end

        #
        # platform method to return the text for a span
        # See PageObject::Accessors#span
        #
        def span_text_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Span, 'span')
          @browser.instance_eval "#{nested_frames(frame_identifiers)}span(identifier).text"
        end

        #
        # platform method to return a PageObject::Elements::Span element
        # See PageObject::Accessors#span
        #
        def span_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Span, 'span')
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}span(identifier)"
          Object::PageObject::Elements::Span.new(element, :platform => :watir_webdriver)
        end

        #
        # platform method to click a button
        # See PageObject::Accessors#button
        #
        def click_button_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Button)
          @browser.instance_eval "#{nested_frames(frame_identifiers)}button(identifier).click"
        end

        #
        # platform method to retrieve a button element
        # See PageObject::Accessors#button
        #
        def button_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Button)
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}button(identifier)"
          Object::PageObject::Elements::Button.new(element, :platform => :watir_webdriver)
        end

        #
        # platform method to retrieve a table element
        # See PageObject::Accessors#table
        #
        def table_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Table, 'table')
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}table(identifier)"
          Object::PageObject::Elements::Table.new(element, :platform => :watir_webdriver)
        end

        #
        # platform method to retrieve the text from a table cell
        # See PageObject::Accessors#cell
        #
        def cell_text_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::TableCell, 'td')
          @browser.instance_eval "#{nested_frames(frame_identifiers)}td(identifier).text"
        end

        #
        # platform method to retrieve a table cell element
        # See PageObject::Accessors#cell
        #
        def cell_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::TableCell, 'td')
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}td(identifier)"
          Object::PageObject::Elements::TableCell.new(element, :platform => :watir_webdriver)
        end

        #
        # platform method to retrieve an image element
        # See PageObject::Accessors#image
        #
        def image_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Image)
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}image(identifier)"
          Object::PageObject::Elements::Image.new(element, :platform => :watir_webdriver)
        end

        #
        # platform method to retrieve a form element
        # See PageObject::Accessors#form
        #
        def form_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Form)
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}form(identifier)"
          Object::PageObject::Elements::Form.new(element, :platform => :watir_webdriver)
        end

        #
        # platform method to retrieve the text from a list item
        # See PageObject::Accessors#list_item
        #
        def list_item_text_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::ListItem, 'li')
          @browser.instance_eval "#{nested_frames(frame_identifiers)}li(identifier).text"
        end

        #
        # platform method to retrieve a list item element
        # See PageObject::Accessors#list_item
        #
        def list_item_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::ListItem, 'li')
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}li(identifier)"
          Object::PageObject::Elements::ListItem.new(element, :platform => :watir_webdriver)
        end

        #
        # platform method to retrieve an unordered list element
        # See PageObject::Accessors#unordered_list
        #
        def unordered_list_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::UnorderedList, 'ul')
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}ul(identifier)"
          Object::PageObject::Elements::UnorderedList.new(element, :platform => :watir_webdriver)
        end

        #
        # platform method to retrieve an ordered list element
        # See PageObject::Accessors#ordered_list
        #
        def ordered_list_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::OrderedList, 'ol')
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}ol(identifier)"
          Object::PageObject::Elements::OrderedList.new(element, :platform => :watir_webdriver)
        end
        
        #
        # platform method to retrieve the text for a h1
        # See PageObject::Accessors#h1
        #
        def h1_text_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h1')
          @browser.instance_eval "#{nested_frames(frame_identifiers)}h1(identifier).text"          
        end
        
        #
        # platform method to retrieve the h1 element
        # See PageObject::Accessors#h1
        #
        def h1_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h1')
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}h1(identifier)"
          Object::PageObject::Elements::Heading.new(element, :platform => :watir_webdriver)
        end  

        #
        # platform method to retrieve the text for a h2
        # See PageObject::Accessors#h2
        #
        def h2_text_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h2')
          @browser.instance_eval "#{nested_frames(frame_identifiers)}h2(identifier).text"          
        end
        
        #
        # platform method to retrieve the h2 element
        # See PageObject::Accessors#h2
        #
        def h2_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h2')
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}h2(identifier)"
          Object::PageObject::Elements::Heading.new(element, :platform => :watir_webdriver)
        end  

        #
        # platform method to retrieve the text for a h3
        # See PageObject::Accessors#h3
        #
        def h3_text_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h3')
          @browser.instance_eval "#{nested_frames(frame_identifiers)}h3(identifier).text"          
        end
        
        #
        # platform method to retrieve the h3 element
        # See PageObject::Accessors#h3
        #
        def h3_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h3')
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}h3(identifier)"
          Object::PageObject::Elements::Heading.new(element, :platform => :watir_webdriver)
        end  

        #
        # platform method to retrieve the text for a h4
        # See PageObject::Accessors#h4
        #
        def h4_text_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h4')
          @browser.instance_eval "#{nested_frames(frame_identifiers)}h4(identifier).text"          
        end
        
        #
        # platform method to retrieve the h4 element
        # See PageObject::Accessors#h4
        #
        def h4_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h4')
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}h4(identifier)"
          Object::PageObject::Elements::Heading.new(element, :platform => :watir_webdriver)
        end  

        #
        # platform method to retrieve the text for a h5
        # See PageObject::Accessors#h5
        #
        def h5_text_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h5')
          @browser.instance_eval "#{nested_frames(frame_identifiers)}h5(identifier).text"          
        end
        
        #
        # platform method to retrieve the h5 element
        # See PageObject::Accessors#h5
        #
        def h5_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h5')
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}h5(identifier)"
          Object::PageObject::Elements::Heading.new(element, :platform => :watir_webdriver)
        end  

        #
        # platform method to retrieve the text for a h6
        # See PageObject::Accessors#h6
        #
        def h6_text_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h6')
          @browser.instance_eval "#{nested_frames(frame_identifiers)}h6(identifier).text"          
        end
        
        #
        # platform method to retrieve the h6 element
        # See PageObject::Accessors#h6
        #
        def h6_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'h6')
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}h6(identifier)"
          Object::PageObject::Elements::Heading.new(element, :platform => :watir_webdriver)
        end  

        #
        # platform method to retrieve the text for a paragraph
        # See PageObject::Accessors#paragraph
        #
        def paragraph_text_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'p')
          @browser.instance_eval "#{nested_frames(frame_identifiers)}p(identifier).text"          
        end
        
        #
        # platform method to retrieve the paragraph element
        # See PageObject::Accessors#paragraph
        #
        def paragraph_for(identifier)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Heading, 'p')
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}p(identifier)"
          Object::PageObject::Elements::Paragraph.new(element, :platform => :watir_webdriver)
        end  

        private
    
        def parse_identifiers(identifier, element, tag_name=nil)
          frame_identifiers = identifier.delete(:frame)
          identifier = add_tagname_if_needed identifier, tag_name if tag_name
          identifier = element.watir_identifier_for identifier
          return identifier, frame_identifiers
        end

        def add_tagname_if_needed identifier, tag
          return identifier if identifier.length < 2 and not identifier[:name]
          identifier[:tag_name] = tag if identifier[:name]
          identifier
        end
    
        def nested_frames(frame_identifiers)
          return if frame_identifiers.nil?
          frame_str = ''
          frame_identifiers.each do |id|
            value = id.values.first
            frame_str += "frame(:#{id.keys.first} => #{value})." if value.to_s.is_integer
            frame_str += "frame(:#{id.keys.first} => '#{value}')." unless value.to_s.is_integer
          end
          frame_str
        end
      end
    end
  end
end
