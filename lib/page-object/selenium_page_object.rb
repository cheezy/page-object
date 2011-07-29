require 'page-object/elements'

module PageObject
  #
  # Selenium implementation of the page object platform driver.  You should not use the
  # class directly.  Instead you should include the PageObject module in your page object
  # and use the methods dynamically added from the PageObject::Accessors module.
  #
  class SeleniumPageObject
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
      wait = Selenium::WebDriver::Wait.new({:timeout => timeout, :message => message})
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

      result && result.dup.each_key { |k| result[k.to_sym] = result.delete(k)}
      result
    end
    
    #
    # platform method to handle attaching to a running window
    # See PageObject#attach_to_window
    #
    def attach_to_window(identifier)
      handles = @browser.window_handles
      handles.each do |handle|
        @browser.switch_to.window handle
        if identifier.keys.first == :title
          return if @browser.title == identifier.values.first
        elsif identifier.keys.first == :url
          return if @browser.current_url == identifier.values.first
        end
      end
    end

    #
    # platform method to get the value stored in a text field
    # See PageObject::Accessors#text_field
    #
    def text_field_value_for(identifier)
      identifier = add_tagname_if_needed identifier, 'input', :type => 'text'
      how, what = Elements::TextField.selenium_identifier_for identifier
      @browser.find_element(how, what).attribute('value')
    end
    
    #
    # platform method to set the value for a text field
    # See PageObject::Accessors#text_field
    #
    def text_field_value_set(identifier, value)
      identifier = add_tagname_if_needed identifier, 'input', :type => 'text'
      how, what = Elements::TextField.selenium_identifier_for identifier
      @browser.find_element(how, what).send_keys(value)
    end
    
    #
    # platform method to retrieve a text field element
    # See PageObject::Accessors#text_field
    #
    def text_field_for(identifier)
      identifier = add_tagname_if_needed identifier, 'input', :type => 'text'
      how, what = Elements::TextField.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      PageObject::Elements::TextField.new(element, :platform => :selenium)
    end
    
    #
    # platform method to get the value stored in a hidden field
    # See PageObject::Accessors#hidden_field
    #
    def hidden_field_value_for(identifier)
      identifier = add_tagname_if_needed identifier, 'input', :type => 'hidden'
      how, what = Elements::HiddenField.selenium_identifier_for identifier
      @browser.find_element(how, what).attribute('value')
    end
    
    #
    # platform method to retrieve a hidden field element
    # See PageObject::Accessors#hidden_field
    #
    def hidden_field_for(identifier)
      identifier = add_tagname_if_needed identifier, 'input', :type => 'hidden'
      how, what = Elements::HiddenField.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      Elements::HiddenField.new(element, :platform => :selenium)
    end    

    #
    # platform method to set text in a textarea
    # See PageObject::Accessors#text_area
    #
    def text_area_value_set(identifier, value)
      identifier = add_tagname_if_needed identifier, 'textarea'
      how, what = Elements::TextArea.selenium_identifier_for identifier
      @browser.find_element(how, what).send_keys(value)
    end
    
    #
    # platform method to get the text from a textarea
    # See PageObject::Accessors#text_area
    #
    def text_area_value_for(identifier)
      identifier = add_tagname_if_needed identifier, 'textarea'
      how, what = Elements::TextArea.selenium_identifier_for identifier
      @browser.find_element(how, what).attribute('value')
    end
    
    #
    # platform method to get the text area element
    # See PageObject::Accessors#text_area
    #
    def text_area_for(identifier)
      identifier = add_tagname_if_needed identifier, 'textarea'
      how, what = Elements::TextArea.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      Elements::TextArea.new(element, :platform => :selenium)
    end
    
    #
    # platform method to get the currently selected value from a select list
    # See PageObject::Accessors#select_list
    #
    def select_list_value_for(identifier)
      identifier = add_tagname_if_needed identifier, 'select'
      how, what = Elements::SelectList.selenium_identifier_for identifier
      @browser.find_element(how, what).attribute('value')
    end
    
    #
    # platform method to select a value from a select list
    # See PageObject::Accessors#select_list
    #
    def select_list_value_set(identifier, value)
      identifier = add_tagname_if_needed identifier, 'select'
      how, what = Elements::SelectList.selenium_identifier_for identifier
      @browser.find_element(how, what).send_keys(value)
    end
    
    #
    # platform method to return the select list element
    # See PageObject::Accessors#select_list
    #
    def select_list_for(identifier)
      identifier = add_tagname_if_needed identifier, 'select'
      how, what = Elements::SelectList.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      Elements::SelectList.new(element, :platform => :selenium)
    end

    #
    # platform method to click a link
    # See PageObject::Accessors#link
    #
    def click_link_for(identifier)
      identifier = add_tagname_if_needed identifier, "a"
      how, what = Elements::Link.selenium_identifier_for identifier
      @browser.find_element(how, what).click
    end
    
    #
    # platform method to return a PageObject::Elements::Link object
    # see PageObject::Accessors#link
    #
    def link_for(identifier)
      identifier = add_tagname_if_needed identifier, "a"
      how, what = Elements::Link.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      Elements::Link.new(element, :platform => :selenium)
    end

    #
    # platform method to check a checkbox
    # See PageObject::Accessors#checkbox
    #
    def check_checkbox(identifier)
      identifier = add_tagname_if_needed identifier, 'input', :type => 'checkbox'
      how, what = Elements::CheckBox.selenium_identifier_for identifier
      @browser.find_element(how, what).click unless @browser.find_element(how, what).selected?
    end

    #
    # platform method to uncheck a checkbox
    # See PageObject::Accessors#checkbox
    #
    def uncheck_checkbox(identifier)
      identifier = add_tagname_if_needed identifier, 'input', :type => 'checkbox'
      how, what = Elements::CheckBox.selenium_identifier_for identifier
      @browser.find_element(how, what).click if @browser.find_element(how, what).selected?
    end

    #
    # platform method to determine if a checkbox is checked
    # See PageObject::Accessors#checkbox
    #
    def checkbox_checked?(identifier)
      identifier = add_tagname_if_needed identifier, 'input', :type => 'checkbox'
      how, what = Elements::CheckBox.selenium_identifier_for identifier
      @browser.find_element(how, what).selected?
    end
    
    #
    # platform method to return a PageObject::Elements::CheckBox element
    # See PageObject::Accessors#checkbox
    #
    def checkbox_for(identifier)
      identifier = add_tagname_if_needed identifier, 'input', :type => 'checkbox'
      how, what = Elements::CheckBox.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      Elements::CheckBox.new(element, :platform => :selenium)
    end

    #
    # platform method to select a radio button
    # See PageObject::Accessors#radio_button
    #
    def select_radio(identifier)
      identifier = add_tagname_if_needed identifier, 'input', :type => 'radio'
      how, what = Elements::RadioButton.selenium_identifier_for identifier
      @browser.find_element(how, what).click unless @browser.find_element(how, what).selected?
    end

    #
    # platform method to clear a radio button
    # See PageObject::Accessors#radio_button
    #
    def clear_radio(identifier)
      identifier = add_tagname_if_needed identifier, 'input', :type => 'radio'
      how, what = Elements::RadioButton.selenium_identifier_for identifier
      @browser.find_element(how, what).click if @browser.find_element(how, what).selected?
    end

    #
    # platform method to determine if a radio button is selected
    # See PageObject::Accessors#radio_button
    #
    def radio_selected?(identifier)
      identifier = add_tagname_if_needed identifier, 'input', :type => 'radio'
      how, what = Elements::RadioButton.selenium_identifier_for identifier
      @browser.find_element(how, what).selected?
    end
    
    #
    # platform method to return a PageObject::Eements::RadioButton element
    # See PageObject::Accessors#radio_button
    #
    def radio_button_for(identifier)
      identifier = add_tagname_if_needed identifier, 'input', :type => 'radio'
      how, what = Elements::RadioButton.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      PageObject::Elements::RadioButton.new(element, :platform => :selenium)
    end
    
    #
    # platform method to return the text for a div
    # See PageObject::Accessors#div
    #    
    def div_text_for(identifier)
      identifier = add_tagname_if_needed identifier, 'div'
      how, what = Elements::Div.selenium_identifier_for identifier
      @browser.find_element(how, what).text
    end
    
    #
    # platform method to return a PageObject::Elements::Div element
    # See PageObject::Accessors#div
    #
    def div_for(identifier)
      identifier = add_tagname_if_needed identifier, 'div'
      how, what = Elements::Div.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      PageObject::Elements::Div.new(element, :platform => :selenium)
    end
    
    #
    # platform method to return the text for a span
    # See PageObject::Accessors#span
    #
    def span_text_for(identifier)
      identifier = add_tagname_if_needed identifier, 'span'
      how, what = Elements::Span.selenium_identifier_for identifier
      @browser.find_element(how, what).text
    end
    
    #
    # platform method to return a PageObject::Elements::Span element
    # See PageObject::Accessors#span
    #
    def span_for(identifier)
      identifier = add_tagname_if_needed identifier, 'span'
      how, what = Elements::Span.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      PageObject::Elements::Span.new(element, :platform => :selenium)
    end
    
    #
    # platform method to click a button
    # See PageObject::Accessors#button
    #
    def click_button_for(identifier)
      identifier = add_tagname_if_needed identifier, 'input', :type => 'submit'
      how, what = Elements::Button.selenium_identifier_for identifier
      @browser.find_element(how, what).click
    end
    
    #
    # platform method to retrieve a button element
    # See PageObject::Accessors#button
    #
    def button_for(identifier)
      identifier = add_tagname_if_needed identifier, 'input', :type => 'submit'
      how, what = Elements::Button.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      PageObject::Elements::Button.new(element, :platform => :selenium)
    end

    #
    # platform method to retrieve a table element
    # See PageObject::Accessors#table
    #
    def table_for(identifier)
      identifier = add_tagname_if_needed identifier, 'table'
      how, what = Elements::Table.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      PageObject::Elements::Table.new(element, :platform => :selenium)
    end
    
    #
    # platform method to retrieve the text from a table cell
    # See PageObject::Accessors#cell
    #
    def cell_text_for(identifier)
      identifier = add_tagname_if_needed identifier, 'td'
      how, what = Elements::TableCell.selenium_identifier_for identifier
      @browser.find_element(how, what).text
    end
    
    #
    # platform method to retrieve a table cell element
    # See PageObject::Accessors#cell
    #
    def cell_for(identifier)
      identifier = add_tagname_if_needed identifier, 'td'
      how, what = Elements::TableCell.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      PageObject::Elements::TableCell.new(element, :platform => :selenium)
    end

    #
    # platform method to retrieve an image element
    # See PageObject::Accessors#image
    #
    def image_for(identifier)
      identifier = add_tagname_if_needed identifier, 'img'
      how, what = Elements::Image.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      PageObject::Elements::Image.new(element, :platform => :selenium)
    end
    
    #
    # platform method to retrieve a form element
    # See PageObject::Accessors#form
    #
    def form_for(identifier)
      identifier = add_tagname_if_needed identifier, 'form'
      how, what = Elements::Form.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      PageObject::Elements::Form.new(element, :platform => :selenium)
    end

    #
    # platform method to retrieve the text from a list item
    # See PageObject::Accessors#list_item
    #
    def list_item_text_for(identifier)
      identifier = add_tagname_if_needed identifier, 'li'
      how, what = Elements::ListItem.selenium_identifier_for identifier
      @browser.find_element(how, what).text
    end
    
    #
    # platform method to retrieve a list item element
    # See PageObject::Accessors#list_item
    #
    def list_item_for(identifier)
      identifier = add_tagname_if_needed identifier, 'li'
       how, what = Elements::ListItem.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      PageObject::Elements::ListItem.new(element, :platform => :selenium)
    end
    
    #
    # platform method to retrieve an unordered list element
    # See PageObject::Accessors#unordered_list
    #
    def unordered_list_for(identifier)
      identifier = add_tagname_if_needed identifier, 'ul'
      how, what = Elements::UnorderedList.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      PageObject::Elements::UnorderedList.new(element, :platform => :selenium)
    end
    
    #
    # platform method to retrieve an ordered list element
    # See PageObject::Accessors#ordered_list
    #
    def ordered_list_for(identifier)
      identifier = add_tagname_if_needed identifier, 'ol'
      how, what = Elements::OrderedList.selenium_identifier_for identifier
      element = @browser.find_element(how, what)
      PageObject::Elements::OrderedList.new(element, :platform => :selenium)
    end

    private
    
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
      return false if identifier[:text] and tag == 'div'
      true
    end
        
  end
end
