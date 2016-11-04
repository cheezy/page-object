require 'page-object/elements'
require 'page-object/core_ext/string'
require 'page-object/platforms/selenium_webdriver/surrogate_selenium_element'

module PageObject
  module Platforms
    module SeleniumWebDriver

      #
      # Selenium implementation of the page object platform driver.  You should not use the
      # class directly.  Instead you should include the PageObject module in your page object
      # and use the methods dynamically added from the PageObject::Accessors module.
      #
      class PageObject

        PLATFORM_NAME = :selenium_webdriver

        def self.define_widget_accessors(widget_tag, widget_class, base_element_tag)
          define_widget_singular_accessor(base_element_tag, widget_class, widget_tag)
          define_widget_multiple_accessor(base_element_tag, widget_class, widget_tag)
        end

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
          yield
          begin
            alert = @browser.switch_to.alert
            value = alert.text
            alert.accept
          rescue Selenium::WebDriver::Error::NoAlertPresentError
          end
          value
        end

        #
        # platform method to handle a confirm popup
        # See PageObject#confirm
        #
        def confirm(response, frame=nil, &block)
          yield
          begin
            alert = @browser.switch_to.alert
            value = alert.text
            response ? alert.accept : alert.dismiss
          rescue Selenium::WebDriver::Error::NoAlertPresentError
          end
          value
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
        # platform method to execute javascript on the browser
        # See PageObject#execute_script
        #
        def execute_script(script, *args)
          @browser.execute_script(script, *args)
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
              (key == :url and @browser.current_url.include?(value))
              return @browser.switch_to.window handle, &block
            end
          end
        end

        #
        # find the element that has focus
        #
        def element_with_focus
          element = @browser.execute_script("return document.activeElement")
          type = element.attribute(:type).to_s.downcase if element.tag_name.to_sym == :input
          cls = ::PageObject::Elements.element_class_for(element.tag_name, type)
          cls.new(element, :platform => self.class::PLATFORM_NAME)
        end

        #
        # platform method to switch to a frame and execute a block
        # See PageObject#in_frame
        #
        def in_frame(identifier, frame=nil, &block)
          switch_to_frame([frame: identifier])
          block.call(nil)
          @browser.switch_to.default_content
        end

        #
        # platform method to switch to an iframe and execute a block
        # See PageObject#in_frame
        #
        def in_iframe(identifier, frame=nil, &block)
          switch_to_frame([iframe: identifier])
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
          process_selenium_call(identifier, Elements::TextField, 'input', :type => 'text') do |how, what|
            @browser.find_element(how, what).attribute('value')
          end
        end


        #
        # platform method to set the value for a text field
        # See PageObject::Accessors#text_field
        #
        def text_field_value_set(identifier, value)
          process_selenium_call(identifier, Elements::TextField, 'input', :type => 'text') do |how, what|
            @browser.find_element(how, what).clear
            @browser.find_element(how, what).send_keys(value)
          end
        end

        #
        # platform method to retrieve a text field element
        # See PageObject::Accessors#text_field
        #
        def text_field_for(identifier)
          find_selenium_element(identifier, Elements::TextField, 'input', :type => 'text')
        end

        #
        # platform method to retrieve all text field elements
        #
        def text_fields_for(identifier)
          find_selenium_elements(identifier, Elements::TextField, 'input', :type => 'text')
        end

        #
        # platform method to get the value stored in a hidden field
        # See PageObject::Accessors#hidden_field
        #
        def hidden_field_value_for(identifier)
          process_selenium_call(identifier, Elements::HiddenField, 'input', :type => 'hidden') do |how, what|
            @browser.find_element(how, what).attribute('value')
          end
        end

        #
        # platform method to retrieve a hidden field element
        # See PageObject::Accessors#hidden_field
        #
        def hidden_field_for(identifier)
          find_selenium_element(identifier, Elements::HiddenField, 'input', :type => 'hidden')
        end

        #
        # platform method to retrieve all hidden field elements
        #
        def hidden_fields_for(identifier)
          find_selenium_elements(identifier, Elements::HiddenField, 'input', :type => 'hidden')
        end

        #
        # platform method to set text in a textarea
        # See PageObject::Accessors#text_area
        #
        def text_area_value_set(identifier, value)
          process_selenium_call(identifier, Elements::TextArea, 'textarea') do |how, what|
            text_area = @browser.find_element(how, what)
            text_area.clear
            text_area.send_keys(value)
          end
        end

        #
        # platform method to get the text from a textarea
        # See PageObject::Accessors#text_area
        #
        def text_area_value_for(identifier)
          process_selenium_call(identifier, Elements::TextArea, 'textarea') do |how, what|
            @browser.find_element(how, what).attribute('value')
          end
        end

        #
        # platform method to get the text area element
        # See PageObject::Accessors#text_area
        #
        def text_area_for(identifier)
          find_selenium_element(identifier, Elements::TextArea, 'textarea')
        end

        #
        # platform method to retrieve all text area elements
        #
        def text_areas_for(identifier)
          find_selenium_elements(identifier, Elements::TextArea, 'textarea')
        end

        #
        # platform method to get the currently selected value from a select list
        # See PageObject::Accessors#select_list
        #
        def select_list_value_for(identifier)
          process_selenium_call(identifier, Elements::SelectList, 'select') do |how, what|
            selected = nil
            @browser.find_element(how, what).find_elements(:tag_name => 'option').each do |o|
              if selected.nil?
                selected = o.text if o.selected?
              end
            end
            selected
          end
        end

        #
        # platform method to select a value from a select list
        # See PageObject::Accessors#select_list
        #
        def select_list_value_set(identifier, value)
          process_selenium_call(identifier, Elements::SelectList, 'select') do |how, what|
            select_list = @browser.find_element(how, what)
            select_list.find_elements(:tag_name => 'option').find do |option|
              option.text == value
            end.click
          end
        end

        #
        # platform method to return the select list element
        # See PageObject::Accessors#select_list
        #
        def select_list_for(identifier)
          find_selenium_element(identifier, Elements::SelectList, 'select')
        end

        #
        # platform method to retrieve all select list elements
        #
        def select_lists_for(identifier)
          find_selenium_elements(identifier, Elements::SelectList, 'select')
        end

        #
        # platform method to click a link
        # See PageObject::Accessors#link
        #
        def click_link_for(identifier)
          process_selenium_call(identifier, Elements::Link, 'a') do |how, what|
            @browser.find_element(how, what).click
          end
        end

        #
        # platform method to return a PageObject::Elements::Link object
        # see PageObject::Accessors#link
        #
        def link_for(identifier)
          find_selenium_element(identifier, Elements::Link, 'a')
        end

        #
        # platform method to retrieve all link elements
        #
        def links_for(identifier)
          find_selenium_elements(identifier, Elements::Link, 'a')
        end

        #
        # platform method to check a checkbox
        # See PageObject::Accessors#checkbox
        #
        def check_checkbox(identifier)
          process_selenium_call(identifier, Elements::CheckBox, 'input', :type => 'checkbox') do |how, what|
            @browser.find_element(how, what).click unless @browser.find_element(how, what).selected?
          end
        end

        #
        # platform method to uncheck a checkbox
        # See PageObject::Accessors#checkbox
        #
        def uncheck_checkbox(identifier)
          process_selenium_call(identifier, Elements::CheckBox, 'input', :type => 'checkbox') do |how, what|
            @browser.find_element(how, what).click if @browser.find_element(how, what).selected?
          end
        end

        #
        # platform method to determine if a checkbox is checked
        # See PageObject::Accessors#checkbox
        #
        def checkbox_checked?(identifier)
          process_selenium_call(identifier, Elements::CheckBox, 'input', :type => 'checkbox') do |how, what|
            @browser.find_element(how, what).selected?
          end
        end

        #
        # platform method to return a PageObject::Elements::CheckBox element
        # See PageObject::Accessors#checkbox
        #
        def checkbox_for(identifier)
          find_selenium_element(identifier, Elements::CheckBox, 'input', :type => 'checkbox')
        end

        #
        # platform method to retrieve all checkbox elements
        #
        def checkboxs_for(identifier)
          find_selenium_elements(identifier, Elements::CheckBox, 'input', :type => 'checkbox')
        end

        #
        # platform method to select a radio button
        # See PageObject::Accessors#radio_button
        #
        def select_radio(identifier)
          process_selenium_call(identifier, Elements::RadioButton, 'input', :type => 'radio') do |how, what|
            @browser.find_element(how, what).click unless @browser.find_element(how, what).selected?
          end
        end

        #
        # platform method to determine if a radio button is selected
        # See PageObject::Accessors#radio_button
        #
        def radio_selected?(identifier)
          process_selenium_call(identifier, Elements::RadioButton, 'input', :type => 'radio') do |how, what|
            @browser.find_element(how, what).selected?
          end
        end

        #
        # platform method to return a PageObject::Eements::RadioButton element
        # See PageObject::Accessors#radio_button
        #
        def radio_button_for(identifier)
          find_selenium_element(identifier, Elements::RadioButton, 'input', :type => 'radio')
        end

        #
        # platform method to retrieve all radio button elements
        #
        def radio_buttons_for(identifier)
          find_selenium_elements(identifier, Elements::RadioButton, 'input', :type => 'radio')
        end

        #
        # platform method to return the text for a div
        # See PageObject::Accessors#div
        #
        def div_text_for(identifier)
          process_selenium_call(identifier, Elements::Div, 'div') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to return a PageObject::Elements::Div element
        # See PageObject::Accessors#div
        #
        def div_for(identifier)
          find_selenium_element(identifier, Elements::Div, 'div')
        end

        #
        # platform method to retrieve all div elements
        #
        def divs_for(identifier)
          find_selenium_elements(identifier, Elements::Div, 'div')
        end

        #
        # platform method to return the text for a span
        # See PageObject::Accessors#span
        #
        def span_text_for(identifier)
          process_selenium_call(identifier, Elements::Span, 'span') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to return a PageObject::Elements::Span element
        # See PageObject::Accessors#span
        #
        def span_for(identifier)
          find_selenium_element(identifier, Elements::Span, 'span')
        end

        #
        # platform method to retrieve all span elements
        #
        def spans_for(identifier)
          find_selenium_elements(identifier, Elements::Span, 'span')
        end

        #
        # platform method to click a button
        # See PageObject::Accessors#button
        #
        def click_button_for(identifier)
          process_selenium_call(identifier, Elements::Button, 'input', :type => 'submit') do |how, what|
            @browser.find_element(how, what).click
          end
        end

        #
        # platform method to retrieve a button element
        # See PageObject::Accessors#button
        #
        def button_for(identifier)
          find_selenium_element(identifier, Elements::Button, 'input', :type => 'submit')
        end

        #
        # platform method to retrieve an array of button elements
        #
        def buttons_for(identifier)
          find_selenium_elements(identifier, Elements::Button, 'input', :type => 'submit')
        end

        #
        # platform method to return the text for a table
        # See PageObject::Accessors#table
        #
        def table_text_for(identifier)
          process_selenium_call(identifier, Elements::Table, 'table') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to retrieve a table element
        # See PageObject::Accessors#table
        #
        def table_for(identifier)
          find_selenium_element(identifier, Elements::Table, 'table')
        end

        #
        # platform method to retrieve all table elements
        #
        def tables_for(identifier)
          find_selenium_elements(identifier, Elements::Table, 'table')
        end

        #
        # platform method to retrieve the text from a table cell
        # See PageObject::Accessors#cell
        #
        def cell_text_for(identifier)
          process_selenium_call(identifier, Elements::TableCell, 'td') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to retrieve a table cell element
        # See PageObject::Accessors#cell
        #
        def cell_for(identifier)
          find_selenium_element(identifier, Elements::TableCell, 'td')
        end

        #
        # platform method to retrieve all table cell elements
        #
        def cells_for(identifier)
          find_selenium_elements(identifier, Elements::TableCell, 'td')
        end

        #
        # platform method to retrieve the text from a table row
        # See PageObject::Accessors#row
        #
        def row_text_for(identifier)
          process_selenium_call(identifier, Elements::TableRow, 'tr') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to retrieve a table row element
        # See PageObject::Accessors#row
        #
        def row_for(identifier)
          find_selenium_element(identifier, Elements::TableRow, 'tr')
        end

        #
        # platform method to retrieve all table row elements
        #
        def rows_for(identifier)
          find_selenium_elements(identifier, Elements::TableRow, 'tr')
        end

        #
        # platform method to retrieve load status of an image element
        # See PageObject::Accessors#image
        #
        def image_loaded_for(identifier)
          process_selenium_call(identifier, Elements::Image, 'img') do |how, what|
            element = @browser.find_element(how, what)
            @browser.execute_script(
              'return typeof arguments[0].naturalWidth != "undefined" && arguments[0].naturalWidth > 0',
              element
            )
          end
        end

        #
        # platform method to retrieve an image element
        # See PageObject::Accessors#image
        #
        def image_for(identifier)
          find_selenium_element(identifier, Elements::Image, 'img')
        end

        #
        # platform method to retrieve all image elements
        #
        def images_for(identifier)
          find_selenium_elements(identifier, Elements::Image, 'img')
        end

        #
        # platform method to retrieve a form element
        # See PageObject::Accessors#form
        #
        def form_for(identifier)
          find_selenium_element(identifier, Elements::Form, 'form')
        end

        #
        # platform method to retrieve all forms
        #
        def forms_for(identifier)
          find_selenium_elements(identifier, Elements::Form, 'form')
        end

        #
        # platform method to retrieve the text from a list item
        # See PageObject::Accessors#list_item
        #
        def list_item_text_for(identifier)
          process_selenium_call(identifier, Elements::ListItem, 'li') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to retrieve a list item element
        # See PageObject::Accessors#list_item
        #
        def list_item_for(identifier)
          find_selenium_element(identifier, Elements::ListItem, 'li')
        end

        #
        # platform method to retrieve all list items
        #
        def list_items_for(identifier)
          find_selenium_elements(identifier, Elements::ListItem, 'li')
        end

        #
        # platform method to retrieve the text from an unordered list
        # See PageObject::Accessors#unordered_list
        #
        def unordered_list_text_for(identifier)
          process_selenium_call(identifier, Elements::UnorderedList, 'ul') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to retrieve an unordered list element
        # See PageObject::Accessors#unordered_list
        #
        def unordered_list_for(identifier)
          find_selenium_element(identifier, Elements::UnorderedList, 'ul')
        end

        #
        # platform method to retrieve all unordered lists
        #
        def unordered_lists_for(identifier)
          find_selenium_elements(identifier, Elements::UnorderedList, 'ul')
        end

        #
        # platform method to retrieve the text from an ordered list
        # See PageObject::Accessors#ordered_list
        #
        def ordered_list_text_for(identifier)
          process_selenium_call(identifier, Elements::OrderedList, 'ol') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to retrieve an ordered list element
        # See PageObject::Accessors#ordered_list
        #
        def ordered_list_for(identifier)
          find_selenium_element(identifier, Elements::OrderedList, 'ol')
        end

        #
        # platform method to retrieve all ordered lists
        #
        def ordered_lists_for(identifier)
          find_selenium_elements(identifier, Elements::OrderedList, 'ol')
        end

        #
        # platform method to retrieve the text from a h1
        # See PageObject::Accessors#h1
        #
        def h1_text_for(identifier)
          process_selenium_call(identifier, Elements::Heading, 'h1') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to retrieve the h1 element
        # See PageObject::Accessors#h1
        #
        def h1_for(identifier)
          find_selenium_element(identifier, Elements::Heading, 'h1')
        end

        #
        # platform method to retrieve all h1 elements
        #
        def h1s_for(identifier)
          find_selenium_elements(identifier, Elements::Heading, 'h1')
        end

        #
        # platform method to retrieve the text from a h2
        # See PageObject::Accessors#h2
        #
        def h2_text_for(identifier)
          process_selenium_call(identifier, Elements::Heading, 'h2') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to retrieve the h2 element
        # See PageObject::Accessors#h2
        #
        def h2_for(identifier)
          find_selenium_element(identifier, Elements::Heading, 'h2')
        end

        #
        # platform method to retrieve all h2 elements
        #
        def h2s_for(identifier)
          find_selenium_elements(identifier, Elements::Heading, 'h2')
        end

        #
        # platform method to retrieve the text from a h3
        # See PageObject::Accessors#h3
        #
        def h3_text_for(identifier)
          process_selenium_call(identifier, Elements::Heading, 'h3') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to retrieve the h3 element
        # See PageObject::Accessors#h3
        #
        def h3_for(identifier)
          find_selenium_element(identifier, Elements::Heading, 'h3')
        end

        #
        # platform method to retrieve all h3 elements
        #
        def h3s_for(identifier)
          find_selenium_elements(identifier, Elements::Heading, 'h3')
        end

        #
        # platform method to retrieve the text from a h4
        # See PageObject::Accessors#h4
        #
        def h4_text_for(identifier)
          process_selenium_call(identifier, Elements::Heading, 'h4') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to retrieve the h4 element
        # See PageObject::Accessors#h4
        #
        def h4_for(identifier)
          find_selenium_element(identifier, Elements::Heading, 'h4')
        end

        #
        # platform method to retrieve all h4 elements
        #
        def h4s_for(identifier)
          find_selenium_elements(identifier, Elements::Heading, 'h4')
        end

        #
        # platform method to retrieve the text from a h5
        # See PageObject::Accessors#h5
        #
        def h5_text_for(identifier)
          process_selenium_call(identifier, Elements::Heading, 'h5') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to retrieve the h5 element
        # See PageObject::Accessors#h5
        #
        def h5_for(identifier)
          find_selenium_element(identifier, Elements::Heading, 'h5')
        end

        #
        # platform method to retrieve all h5 elements
        #
        def h5s_for(identifier)
          find_selenium_elements(identifier, Elements::Heading, 'h5')
        end

        #
        # platform method to retrieve the text from a h6
        # See PageObject::Accessors#h6
        #
        def h6_text_for(identifier)
          process_selenium_call(identifier, Elements::Heading, 'h6') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to retrieve the h6 element
        # See PageObject::Accessors#h6
        #
        def h6_for(identifier)
          find_selenium_element(identifier, Elements::Heading, 'h6')
        end

        #
        # platform method to retrieve all h6 elements
        #
        def h6s_for(identifier)
          find_selenium_elements(identifier, Elements::Heading, 'h6')
        end

        #
        # platform method to retrieve the text for a paragraph
        # See PageObject::Accessors#paragraph
        #
        def paragraph_text_for(identifier)
          process_selenium_call(identifier, Elements::Paragraph, 'p') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to retrieve the paragraph element
        # See PageObject::Accessors#paragraph
        #
        def paragraph_for(identifier)
          find_selenium_element(identifier, Elements::Paragraph, 'p')
        end

        #
        # platform method to retrieve all paragraph elements
        #
        def paragraphs_for(identifier)
          find_selenium_elements(identifier, Elements::Paragraph, 'p')
        end

        #
        # platform method to return the text for a label
        # See PageObject::Accessors#label
        #
        def label_text_for(identifier)
          process_selenium_call(identifier, Elements::Label, 'label') do |how, what|
            @browser.find_element(how, what).text
          end
        end


        #
        # platform method to return a PageObject::Elements::Label element
        # See PageObject::Accessors#label
        #
        def label_for(identifier)
          find_selenium_element(identifier, Elements::Label, 'label')
        end


        #
        # platform method to retrieve all label elements
        #
        def labels_for(identifier)
          find_selenium_elements(identifier, Elements::Label, 'label')
        end

        #
        # platform method to set the file on a file_field element
        # See PageObject::Accessors#file_field
        #
        def file_field_value_set(identifier, value)
          process_selenium_call(identifier, Elements::FileField, 'input', :type => 'file') do |how, what|
            @browser.find_element(how, what).send_keys(value)
          end
        end

        #
        # platform method to retrieve a file_field element
        # See PageObject::Accessors#file_field
        #
        def file_field_for(identifier)
          find_selenium_element(identifier, Elements::FileField, 'input', :type => 'file')
        end

        #
        # platform method to return an array of file field elements
        #
        def file_fields_for(identifier)
          find_selenium_elements(identifier, Elements::FileField, 'input', :type => 'file')
        end

        #
        # platform method to click on an area
        #
        def click_area_for(identifier)
          process_selenium_call(identifier, Elements::Area, 'area') do |how, what|
            @browser.find_element(how, what).click
          end
        end

        #
        # platform method to retrieve an area element
        #
        def area_for(identifier)
          find_selenium_element(identifier, Elements::Area, 'area')
        end

        #
        # platform method to return an array of area elements
        #
        def areas_for(identifier)
          find_selenium_elements(identifier, Elements::Area, 'area')
        end

        #
        # platform method to retrieve a canvas element
        #
        def canvas_for(identifier)
          find_selenium_element(identifier, Elements::Canvas, 'canvas')
        end

        #
        # platform method to return an array of canvas elements
        #
        def canvass_for(identifier)
          find_selenium_elements(identifier, Elements::Canvas, 'canvas')
        end

        #
        # platform method to retrieve an audio element
        #
        def audio_for(identifier)
          find_selenium_element(identifier, Elements::Audio, 'audio')
        end

        #
        # platform method to return an array of audio elements
        #
        def audios_for(identifier)
          find_selenium_elements(identifier, Elements::Audio, 'audio')
        end

        #
        # platform method to retrieve a video element
        #
        def video_for(identifier)
          find_selenium_element(identifier, Elements::Video, 'video')
        end

        #
        # platform method to return an array of video elements
        #
        def videos_for(identifier)
          find_selenium_elements(identifier, Elements::Video, 'video')
        end

        #
        # platform method to retrieve a generic element
        # See PageObject::Accessors#element
        #
        def element_for(tag, identifier)
          find_selenium_element(identifier, Elements::Element, tag.to_s)
        end

        #
        # platform method to retrieve a collection of generic elements
        # See PageObject::Accessors#elements
        #
        def elements_for(tag, identifier)
          find_selenium_elements(identifier, Elements::Element, tag.to_s)
        end

        #
        # platform method to return a PageObject rooted at an element
        # See PageObject::Accessors#page_section
        #
        def page_for(identifier, page_class)
          find_selenium_page(identifier, page_class)
        end

        #
        # platform method to return a collection of PageObjects rooted at elements
        # See PageObject::Accessors#page_sections
        #
        def pages_for(identifier, page_class)
          SectionCollection[*find_selenium_pages(identifier, page_class)]
        end

       #
        # platform method to return a svg element
        #
        def svg_for(identifier)
          find_selenium_element(identifier, Elements::Element, 'svg')
        end

        #
        # platform method to return an array of svg elements
        #
        def svgs_for(identifier)
          find_selenium_elements(identifier, Elements::Element, 'svg')
        end


        #
        # platform method to retrieve the text from a b
        # See PageObject::Accessors#b
        #
        def b_text_for(identifier)
          process_selenium_call(identifier, Elements::Bold, 'b') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to retrieve the b element
        # See PageObject::Accessors#b
        #
        def b_for(identifier)
          find_selenium_element(identifier, Elements::Bold, 'b')
        end

        #
        # platform method to retrieve all b elements
        #
        def bs_for(identifier)
          find_selenium_elements(identifier, Elements::Bold, 'b')
        end

        #
        # platform method to retrieve the text from a i
        # See PageObject::Accessors#i
        #
        def i_text_for(identifier)
          process_selenium_call(identifier, Elements::Italic, 'i') do |how, what|
            @browser.find_element(how, what).text
          end
        end

        #
        # platform method to retrieve the i element
        # See PageObject::Accessors#i
        #
        def i_for(identifier)
          find_selenium_element(identifier, Elements::Italic, 'i')
        end

        #
        # platform method to retrieve all i elements
        #
        def is_for(identifier)
          find_selenium_elements(identifier, Elements::Italic, 'i')
        end

        private

        def process_selenium_call(identifier, type, tag, other=nil)
          how, what, frame_identifiers = parse_identifiers(identifier, type, tag, other)
          switch_to_frame(frame_identifiers)
          value = yield how, what
          @browser.switch_to.default_content unless frame_identifiers.nil?
          value
        end

        def find_selenium_element(identifier, type, tag, other=nil)
          regexp = delete_regexp(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, type, tag, other)
          switch_to_frame(frame_identifiers)
          begin
            unless regexp
              element = @browser.find_element(how, what)
            else
              elements = @browser.find_elements(how, what)
              element = elements.find {|ele| matches_selector?(ele, regexp[0], regexp[1])}
            end
          rescue Selenium::WebDriver::Error::NoSuchElementError
            @browser.switch_to.default_content unless frame_identifiers.nil?
            return build_null_object(identifier, type, tag, other)
          end
          @browser.switch_to.default_content unless frame_identifiers.nil?
          type.new(element, :platform => self.class::PLATFORM_NAME)
        end

        def find_selenium_elements(identifier, type, tag, other=nil)
          regexp = delete_regexp(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, type, tag, other)
          switch_to_frame(frame_identifiers)
          unless regexp
            elements = @browser.find_elements(how, what)
          else
            eles = @browser.find_elements(how, what)
            elements = eles.find_all {|ele| matches_selector?(ele, regexp[0], regexp[1])}
          end
          @browser.switch_to.default_content unless frame_identifiers.nil?
          elements.map { |element| type.new(element, :platform => self.class::PLATFORM_NAME) }
        end

        def find_selenium_pages(identifier, page_class)
          regexp = delete_regexp(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, Elements::Element, 'element')
          switch_to_frame(frame_identifiers)
          unless regexp
            elements = @browser.find_elements(how, what)
          else
            eles = @browser.find_elements(how, what)
            elements = eles.find_all {|ele| matches_selector?(ele, regexp[0], regexp[1])}
          end
          @browser.switch_to.default_content unless frame_identifiers.nil?
          elements.map { |element| page_class.new(element) }
        end

        def find_selenium_page(identifier, page_class)
          type, tag = Elements::Element, 'element'
          regexp = delete_regexp(identifier)
          how, what, frame_identifiers = parse_identifiers(identifier, type, tag)
          switch_to_frame(frame_identifiers)
          begin
            unless regexp
              element = @browser.find_element(how, what)
            else
              elements = @browser.find_elements(how, what)
              element = elements.find {|ele| matches_selector?(ele, regexp[0], regexp[1])}
            end
          rescue Selenium::WebDriver::Error::NoSuchElementError
            @browser.switch_to.default_content unless frame_identifiers.nil?
            return build_null_object(identifier, type, tag, nil)
          end
          @browser.switch_to.default_content unless frame_identifiers.nil?
          page_class.new(element)
        end

        def build_null_object(identifier, type, tag, other)
          null_element = SurrogateSeleniumElement.new
          null_element.identifier = identifier
          null_element.type = type
          null_element.tag = tag
          null_element.other = other
          null_element.platform = self
          Elements::Element.new(null_element, :platform => self.class::PLATFORM_NAME)
        end

        def delete_regexp(identifier)
          regexp = identifier.find {|ident| ident[1].is_a?(Regexp)}
          identifier.delete(regexp[0]) if regexp
          regexp
        end

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
          return false if identifier.size == 0
          return false if identifier[:index]
          return false if identifier[:action] and tag == 'form'
          return false if identifier[:alt] and tag == 'img'
          return false if identifier[:alt] and tag == 'input' and
            ['submit', 'image', 'button', 'reset'].include? additional[:type]
          return false if identifier[:href] and tag == 'a'
          return false if identifier[:src] and tag == 'input' and
            ['submit', 'image', 'button', 'reset'].include? additional[:type]
          return false if identifier[:src] and tag == 'img'
          return false if identifier[:label]
          return false if identifier[:text] and tag == 'input' and additional[:type] == 'hidden'
          return false if identifier[:text] and tag == 'input' and additional[:type] == 'text'
          return false if identifier[:text] and ['div', 'span', 'td', 'label', 'li'].include? tag
          return false if identifier[:title] and tag == 'input' and additional[:type] == 'text'
          return false if identifier[:title] and tag == 'input' and additional[:type] == 'file'
          return false if identifier[:title] and tag == 'a'
          return false if identifier[:title] and tag == 'span'
          return false if identifier[:title] and tag == 'div'
          return false if identifier[:value] and tag == 'input' and
            ['radio', 'submit', 'image', 'button', 'reset', 'checkbox', 'hidden'].include? additional[:type]
          true
        end

        def matches_selector?(element, how, what)
          what === fetch_value(element, how)
        end

        def fetch_value(element, how)
          case how
          when :text
            element.text
          when :tag_name
            element.tag_name.downcase
          when :href
            (href = element.attribute(:href)) && href.strip
          else
            element.attribute(how.to_s.gsub("_", "-").to_sym)
          end
        end

        def switch_to_frame(frame_identifiers)
          unless frame_identifiers.nil?
            frame_identifiers.each do |frame|
              frame_id = frame.values.first
              value = frame_id.values.first
              @browser.switch_to.frame(value)
            end
          end
        end

        def self.define_widget_multiple_accessor(base_element_tag, widget_class, widget_tag)
          send(:define_method, "#{widget_tag}s_for") do |identifier|
            find_selenium_elements(identifier, widget_class, base_element_tag)
          end
        end

        def self.define_widget_singular_accessor(base_element_tag, widget_class, widget_tag)
          send(:define_method, "#{widget_tag}_for") do |identifier|
            find_selenium_element(identifier, widget_class, base_element_tag)
          end
        end

      end
    end
  end
end
