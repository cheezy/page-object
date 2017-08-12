require 'page-object/elements'


module PageObject
  module Platforms
    module Watir

      #
      # Watir implementation of the page object platform driver.  You should not use the
      # class directly.  Instead you should include the PageObject module in your page object
      # and use the methods dynamically added from the PageObject::Accessors module.
      #
      class PageObject
        attr_reader :browser

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
          @browser.wait_until(timeout: timeout, message: message, &block)
        end

        #
        # platform method to handle an alert popup
        # See PageObject#alert
        #
        def alert(frame=nil, &block)
          switch_to_frame(frame)
          yield
          value = nil
          if @browser.alert.exists?
            value = @browser.alert.text
            @browser.alert.ok
          end
          switch_to_default_content(frame)
          value
        end

        #
        # platform method to handle a confirm popup
        # See PageObject#confirm
        #
        def confirm(response, frame=nil, &block)
          switch_to_frame(frame)
          yield
          value = nil
          if @browser.alert.exists?
            value = @browser.alert.text
            response ? @browser.alert.ok : @browser.alert.close
          end
          switch_to_default_content(frame)
          value
        end

        #
        # platform method to handle a prompt popup
        # See PageObject#prompt
        #
        def prompt(answer, frame=nil, &block)
          switch_to_frame(frame)
          @browser.wd.execute_script "window.prompt = function(text, value) { window.__lastWatirPrompt = { message: text, default_value: value }; return #{answer}; }"
          yield
          result = @browser.wd.execute_script "return window.__lastWatirPrompt"
          switch_to_default_content(frame)
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
          win_id = {identifier.keys.first => /#{Regexp.escape(identifier.values.first)}/}
          @browser.window(win_id).use &block
        end

        def element_with_focus
          element = browser.execute_script("return document.activeElement")
          type = element.type.to_sym if element.tag_name.to_sym == :input
          cls = ::PageObject::Elements.element_class_for(element.tag_name, type)
          cls.new(element)
        end

        #
        # platform method to switch to a frame and execute a block
        # See PageObject#in_frame
        #
        def in_frame(identifier, frame=nil, &block)
          frame = [] if frame.nil?
          frame << {frame: identifier}
          block.call(frame)
        end

        #
        # platform method to switch to an iframe and execute a block
        # See PageObject#in_frame
        #
        def in_iframe(identifier, frame=nil, &block)
          frame = [] if frame.nil?
          frame << {iframe: identifier}
          block.call(frame)
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
          @browser.cookies.clear
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
          process_watir_call("text_field(identifier).value", Elements::TextField, identifier)
        end

        #
        # platform method to set the value for a text field
        # See PageObject::Accessors#text_field
        #
        def text_field_value_set(identifier, value)
          process_watir_call("text_field(identifier).set(value)", Elements::TextField, identifier, value)
        end

        #
        # platform method to retrieve a text field element
        # See PageObject::Accessors#text_field
        #
        def text_field_for(identifier)
          find_watir_element("text_field(identifier)", Elements::TextField, identifier)
        end

        #
        # platform method to retrieve an array of text field elements
        #
        def text_fields_for(identifier)
          elements = find_watir_elements("text_fields(identifier)", Elements::TextField, identifier)
          elements.select { |e| e.element.tag_name == 'input' }
        end

        #
        # platform method to get the value stored in a hidden field
        # See PageObject::Accessors#hidden_field
        #
        def hidden_field_value_for(identifier)
          process_watir_call("hidden(identifier).value", Elements::HiddenField, identifier)
        end

        #
        # platform method to retrieve a hidden field element
        # See PageObject::Accessors#hidden_field
        #
        def hidden_field_for(identifier)
          find_watir_element("hidden(identifier)", Elements::HiddenField, identifier)
        end

        #
        # platform method to retrieve an array of hidden field elements
        #
        def hidden_fields_for(identifier)
          find_watir_elements("hiddens(identifier)", Elements::HiddenField, identifier)
        end

        #
        # platform method to set text in a textarea
        # See PageObject::Accessors#text_area
        #
        def text_area_value_set(identifier, value)
          process_watir_call("textarea(identifier).set(value)", Elements::TextArea,
                             identifier, value)
        end

        #
        # platform method to get the text from a textarea
        # See PageObject::Accessors#text_area
        #
        def text_area_value_for(identifier)
          process_watir_call("textarea(identifier).value", Elements::TextArea, identifier)
        end

        #
        # platform method to get the text area element
        # See PageObject::Accessors#text_area
        #
        def text_area_for(identifier)
          find_watir_element("textarea(identifier)", Elements::TextArea, identifier)
        end

        #
        # platform method to retrieve an array of textarea elements
        #
        def text_areas_for(identifier)
          find_watir_elements("textareas(identifier)", Elements::TextArea, identifier)
        end

        #
        # platform method to get the currently selected value from a select list
        # See PageObject::Accessors#select_list
        #
        def select_list_value_for(identifier)
          options = find_watir_elements("select_list(identifier).selected_options",
                             Elements::SelectList, identifier)
          return nil if options.empty?
          options.first.text
        end

        #
        # platform method to select a value from a select list
        # See PageObject::Accessors#select_list
        #
        def select_list_value_set(identifier, value)
          process_watir_call("select_list(identifier).select(value)", Elements::SelectList,
                             identifier, value)
        end

        #
        # platform method to return the select list element
        # See PageObject::Accessors#select_list
        #
        def select_list_for(identifier)
          find_watir_element("select_list(identifier)", Elements::SelectList, identifier)
        end

        #
        # platform method to retrieve an array of select_list elements
        #
        def select_lists_for(identifier)
          find_watir_elements("select_lists(identifier)", Elements::SelectList, identifier)
        end

        #
        # platform method to click a link
        # See PageObject::Accessors#link
        #
        def click_link_for(identifier)
          call = "link(identifier)"
          process_watir_call("#{call}.click if identifier", Elements::Link, identifier)
        end

        #
        # platform method to return a PageObject::Elements::Link object
        # see PageObject::Accessors#link
        #
        def link_for(identifier)
          call = "link(identifier)"
          find_watir_element(call, Elements::Link, identifier)
        end

        #
        # platform method to retrieve an array of link elements
        #
        def links_for(identifier)
          call = "links(identifier)"
          find_watir_elements(call, Elements::Link, identifier)
        end

        #
        # platform method to check a checkbox
        # See PageObject::Accessors#checkbox
        #
        def check_checkbox(identifier)
          process_watir_call("checkbox(identifier).set", Elements::CheckBox, identifier)
        end

        #
        # platform method to uncheck a checkbox
        # See PageObject::Accessors#checkbox
        #
        def uncheck_checkbox(identifier)
          process_watir_call("checkbox(identifier).clear", Elements::CheckBox, identifier)
        end

        #
        # platform method to determine if a checkbox is checked
        # See PageObject::Accessors#checkbox
        #
        def checkbox_checked?(identifier)
          process_watir_call("checkbox(identifier).set?", Elements::CheckBox, identifier)
        end

        #
        # platform method to return a PageObject::Elements::CheckBox element
        # See PageObject::Accessors#checkbox
        #
        def checkbox_for(identifier)
          find_watir_element("checkbox(identifier)", Elements::CheckBox, identifier)
        end

        #
        # platform method to retrieve an array of checkbox elements
        #
        def checkboxs_for(identifier)
          find_watir_elements("checkboxes(identifier)", Elements::CheckBox, identifier)
        end

        #
        # platform method to select a radio button
        # See PageObject::Accessors#radio_button
        #
        def select_radio(identifier)
          process_watir_call("radio(identifier).set", Elements::RadioButton, identifier)
        end

        #
        # platform method to determine if a radio button is selected
        # See PageObject::Accessors#radio_button
        #
        def radio_selected?(identifier)
          process_watir_call("radio(identifier).set?", Elements::RadioButton, identifier)
        end

        #
        # platform method to return a PageObject::Eements::RadioButton element
        # See PageObject::Accessors#radio_button
        #
        def radio_button_for(identifier)
          find_watir_element("radio(identifier)", Elements::RadioButton, identifier)
        end

        #
        # platform method to retrieve an array of radio button elements
        #
        def radio_buttons_for(identifier)
          find_watir_elements("radios(identifier)", Elements::RadioButton, identifier)
        end

        #
        # platform method to return the text for a div
        # See PageObject::Accessors#div
        #
        def div_text_for(identifier)
          process_watir_call("div(identifier).text", Elements::Div, identifier, nil, 'div')
        end

        #
        # platform method to return a PageObject::Elements::Div element
        # See PageObject::Accessors#div
        #
        def div_for(identifier)
          find_watir_element("div(identifier)", Elements::Div, identifier, 'div')
        end

        #
        # platform method to retrieve an array of div elements
        #
        def divs_for(identifier)
          find_watir_elements("divs(identifier)", Elements::Div, identifier, 'div')
        end

        #
        # platform method to return the text for a span
        # See PageObject::Accessors#span
        #
        def span_text_for(identifier)
          process_watir_call("span(identifier).text", Elements::Span, identifier, nil, 'span')
        end

        #
        # platform method to return a PageObject::Elements::Span element
        # See PageObject::Accessors#span
        #
        def span_for(identifier)
          find_watir_element("span(identifier)", Elements::Span, identifier, 'span')
        end

        #
        # platform method to retrieve an array of span elements
        #
        def spans_for(identifier)
          find_watir_elements("spans(identifier)", Elements::Span, identifier, 'span')
        end

        #
        # platform method to click a button
        # See PageObject::Accessors#button
        #
        def click_button_for(identifier)
          call = "button(identifier)"
          process_watir_call("#{call}.click", Elements::Button, identifier)
        end

        #
        # platform method to retrieve a button element
        # See PageObject::Accessors#button
        #
        def button_for(identifier)
          call = "button(identifier)"
          find_watir_element(call, Elements::Button, identifier)
        end

        #
        # platform method to retrieve an array of button elements
        #
        def buttons_for(identifier)
          call = "buttons(identifier)"
          find_watir_elements(call, Elements::Button, identifier)
        end

        #
        # platform method to return the text for a table
        # See PageObject::Accessors#table
        #
        def table_text_for(identifier)
          process_watir_call("table(identifier).text", Elements::Table, identifier, nil, 'table')
        end

        #
        # platform method to retrieve a table element
        # See PageObject::Accessors#table
        #
        def table_for(identifier)
          find_watir_element("table(identifier)", Elements::Table, identifier, 'table')
        end

        #
        # platform method to retrieve an array of table elements
        #
        def tables_for(identifier)
          find_watir_elements("tables(identifier)", Elements::Table, identifier, 'table')
        end

        #
        # platform method to retrieve the text from a table cell
        # See PageObject::Accessors#cell
        #
        def cell_text_for(identifier)
          process_watir_call("td(identifier).text", Elements::TableCell, identifier,
                             nil, 'td')
        end

        #
        # platform method to retrieve a table cell element
        # See PageObject::Accessors#cell
        #
        def cell_for(identifier)
          find_watir_element("td(identifier)", Elements::TableCell, identifier, 'td')
        end

        #
        # platform method to retrieve an array of table cell elements
        #
        def cells_for(identifier)
          find_watir_elements("tds(identifier)", Elements::TableCell, identifier, 'td')
        end

        #
        # platform method to retrieve the text from a table row
        # See PageObject::Accessors#row
        #
        def row_text_for(identifier)
          process_watir_call("tr(identifier).text", Elements::TableRow, identifier,
                             nil, 'tr')
        end

        #
        # platform method to retrieve a table row element
        # See PageObject::Accessors#row
        #
        def row_for(identifier)
          find_watir_element("tr(identifier)", Elements::TableRow, identifier, 'tr')
        end

        #
        # platform method to retrieve an array of table row elements
        #
        def rows_for(identifier)
          find_watir_elements("trs(identifier)", Elements::TableRow, identifier, 'tr')
        end

        #
        # platform method to retrieve load status of an image element
        # See PageObject::Accessors#image
        #
        def image_loaded_for(identifier)
          process_watir_call("image(identifier).loaded?", Elements::Image, identifier)
        end

        #
        # platform method to retrieve an image element
        # See PageObject::Accessors#image
        #
        def image_for(identifier)
          find_watir_element("image(identifier)", Elements::Image, identifier)
        end

        #
        # platform method to retrieve an array of image elements
        #
        def images_for(identifier)
          find_watir_elements("images(identifier)", Elements::Image, identifier)
        end

        #
        # platform method to retrieve a form element
        # See PageObject::Accessors#form
        #
        def form_for(identifier)
          find_watir_element("form(identifier)", Elements::Form, identifier)
        end

        #
        # platform method to retrieve an array of forms
        #
        def forms_for(identifier)
          find_watir_elements("forms(identifier)", Elements::Form, identifier)
        end

        #
        # platform method to retrieve the text from a list item
        # See PageObject::Accessors#list_item
        #
        def list_item_text_for(identifier)
          process_watir_call("li(identifier).text", Elements::ListItem, identifier, nil, 'li')
        end

        #
        # platform method to retrieve a list item element
        # See PageObject::Accessors#list_item
        #
        def list_item_for(identifier)
          find_watir_element("li(identifier)", Elements::ListItem, identifier, 'li')
        end

        #
        # platform method to retrieve an array of list items
        #
        def list_items_for(identifier)
          find_watir_elements("lis(identifier)", Elements::ListItem, identifier, 'li')
        end

        #
        # platform method to retrieve the text from an unordered list
        # See PageObject::Accessors#unordered_list
        #
        def unordered_list_text_for(identifier)
          process_watir_call("ul(identifier).text", Elements::UnorderedList, identifier, nil, 'ul')
        end

        #
        # platform method to retrieve an unordered list element
        # See PageObject::Accessors#unordered_list
        #
        def unordered_list_for(identifier)
          find_watir_element("ul(identifier)", Elements::UnorderedList, identifier, 'ul')
        end

        #
        # platform method to retrieve an array of unordered lists
        #
        def unordered_lists_for(identifier)
          find_watir_elements("uls(identifier)", Elements::UnorderedList, identifier, 'ul')
        end

        #
        # platform method to retrieve the text from an ordered list
        # See PageObject::Accessors#ordered_list
        #
        def ordered_list_text_for(identifier)
          process_watir_call("ol(identifier).text", Elements::OrderedList, identifier, nil, 'ol')
        end

        #
        # platform method to retrieve an ordered list element
        # See PageObject::Accessors#ordered_list
        #
        def ordered_list_for(identifier)
          find_watir_element("ol(identifier)", Elements::OrderedList, identifier, 'ol')
        end

        #
        # platform method to retrieve an array of ordered lists
        #
        def ordered_lists_for(identifier)
          find_watir_elements("ols(identifier)", Elements::OrderedList, identifier, 'ol')
        end

        #
        # platform method to retrieve the text for a h1
        # See PageObject::Accessors#h1
        #
        def h1_text_for(identifier)
          process_watir_call("h1(identifier).text", Elements::Heading, identifier, nil, 'h1')
        end

        #
        # platform method to retrieve the h1 element
        # See PageObject::Accessors#h1
        #
        def h1_for(identifier)
          find_watir_element("h1(identifier)", Elements::Heading, identifier, 'h1')
        end

        #
        # platform method to retrieve an array of h1s
        #
        def h1s_for(identifier)
          find_watir_elements("h1s(identifier)", Elements::Heading, identifier, 'h1')
        end

        #
        # platform method to retrieve the text for a h2
        # See PageObject::Accessors#h2
        #
        def h2_text_for(identifier)
          process_watir_call("h2(identifier).text", Elements::Heading, identifier, nil, 'h2')
        end

        #
        # platform method to retrieve the h2 element
        # See PageObject::Accessors#h2
        #
        def h2_for(identifier)
          find_watir_element("h2(identifier)", Elements::Heading, identifier, 'h2')
        end

        #
        # platform method to retrieve an array of h2s
        #
        def h2s_for(identifier)
          find_watir_elements("h2s(identifier)", Elements::Heading, identifier, 'h2')
        end

        #
        # platform method to retrieve the text for a h3
        # See PageObject::Accessors#h3
        #
        def h3_text_for(identifier)
          process_watir_call("h3(identifier).text", Elements::Heading, identifier, nil, 'h3')
        end

        #
        # platform method to retrieve the h3 element
        # See PageObject::Accessors#h3
        #
        def h3_for(identifier)
          find_watir_element("h3(identifier)", Elements::Heading, identifier, 'h3')
        end

        #
        # platform method to retrieve an array of h3s
        #
        def h3s_for(identifier)
          find_watir_elements("h3s(identifier)", Elements::Heading, identifier, 'h3')
        end

        #
        # platform method to retrieve the text for a h4
        # See PageObject::Accessors#h4
        #
        def h4_text_for(identifier)
          process_watir_call("h4(identifier).text", Elements::Heading, identifier, nil, 'h4')
        end

        #
        # platform method to retrieve the h4 element
        # See PageObject::Accessors#h4
        #
        def h4_for(identifier)
          find_watir_element("h4(identifier)", Elements::Heading, identifier, 'h4')
        end

        #
        # platform method to retrieve an array of h4s
        #
        def h4s_for(identifier)
          find_watir_elements("h4s(identifier)", Elements::Heading, identifier, 'h4')
        end

        #
        # platform method to retrieve the text for a h5
        # See PageObject::Accessors#h5
        #
        def h5_text_for(identifier)
          process_watir_call("h5(identifier).text", Elements::Heading, identifier, nil, 'h5')
        end

        #
        # platform method to retrieve the h5 element
        # See PageObject::Accessors#h5
        #
        def h5_for(identifier)
          find_watir_element("h5(identifier)", Elements::Heading, identifier, 'h5')
        end

        #
        # platform method to retrieve an array of h5s
        #
        def h5s_for(identifier)
          find_watir_elements("h5s(identifier)", Elements::Heading, identifier, 'h5')
        end

        #
        # platform method to retrieve the text for a h6
        # See PageObject::Accessors#h6
        #
        def h6_text_for(identifier)
          process_watir_call("h6(identifier).text", Elements::Heading, identifier, nil, 'h6')
        end

        #
        # platform method to retrieve the h6 element
        # See PageObject::Accessors#h6
        #
        def h6_for(identifier)
          find_watir_element("h6(identifier)", Elements::Heading, identifier, 'h6')
        end

        #
        # platform method to retrieve an array of h6s
        #
        def h6s_for(identifier)
          find_watir_elements("h6s(identifier)", Elements::Heading, identifier, 'h6')
        end

        #
        # platform method to retrieve the text for a paragraph
        # See PageObject::Accessors#paragraph
        #
        def paragraph_text_for(identifier)
          process_watir_call("p(identifier).text", Elements::Paragraph, identifier, nil, 'p')
        end

        #
        # platform method to retrieve the paragraph element
        # See PageObject::Accessors#paragraph
        #
        def paragraph_for(identifier)
          find_watir_element("p(identifier)", Elements::Paragraph, identifier, 'p')
        end

        #
        # platform method to retrieve an array of paragraph elements
        #
        def paragraphs_for(identifier)
          find_watir_elements("ps(identifier)", Elements::Paragraph, identifier, 'p')
        end

        #
        # platform method to return the text for a label
        # See PageObject::Accessors#label
        #
        def label_text_for(identifier)
          process_watir_call("label(identifier).text", Elements::Label, identifier, nil, 'label')
        end

        #
        # platform method to return a PageObject::Elements::Label element
        # See PageObject::Accessors#label
        #
        def label_for(identifier)
          find_watir_element("label(identifier)", Elements::Label, identifier, 'label')
        end

        #
        #
        # platform method to retrieve an array of label elements
        #
        def labels_for(identifier)
          find_watir_elements("labels(identifier)", Elements::Label, identifier, 'label')
        end

        #
        # platform method to set the file on a file_field element
        # See PageObject::Accessors#file_field
        #
        def file_field_value_set(identifier, value)
          process_watir_call("file_field(identifier).set(value)", Elements::FileField,
                             identifier, value)
        end

        #
        # platform method to retrieve a file_field element
        # See PageObject::Accessors#file_field
        #
        def file_field_for(identifier)
          find_watir_element("file_field(identifier)", Elements::FileField, identifier)
        end

        #
        # platform method to retrieve an array of file field elements
        #
        def file_fields_for(identifier)
          find_watir_elements("file_fields(identifier)", Elements::FileField, identifier)
        end

        #
        # platform method to click on an area
        #
        def click_area_for(identifier)
          process_watir_call("area(identifier).click", Elements::Area, identifier, nil, 'area')
        end

        #
        # platform method to retrieve an area element
        #
        def area_for(identifier)
          find_watir_element("area(identifier)", Elements::Area, identifier, 'area')
        end

        #
        # platform method to retrieve an array of area elements
        #
        def areas_for(identifier)
          find_watir_elements("areas(identifier)", Elements::Area, identifier, 'area')
        end

        #
        # platform method to retrieve a canvas element
        #
        def canvas_for(identifier)
          find_watir_element("canvas(identifier)", Elements::Canvas, identifier, 'canvas')
        end

        #
        # platform method to retrieve an array of canvas elements
        #
        def canvass_for(identifier)
          find_watir_elements("canvases(identifier)", Elements::Canvas, identifier, 'canvas')
        end

        #
        # platform method to retrieve an audio element
        #
        def audio_for(identifier)
          find_watir_element("audio(identifier)", Elements::Audio, identifier, 'audio')
        end

        #
        # platform method to retrieve an array of audio elements
        #
        def audios_for(identifier)
          find_watir_elements("audios(identifier)", Elements::Audio, identifier, 'audio')
        end

        #
        # platform method to retrieve a video element
        #
        def video_for(identifier)
          find_watir_element("video(identifier)", Elements::Video, identifier, 'video')
        end

        #
        # platform method to retrieve an array of video elements
        #
        def videos_for(identifier)
          find_watir_elements("videos(identifier)", Elements::Video, identifier, 'video')
        end

        #
        # platform method to return a PageObject::Elements::Element element
        # See PageObject::Accessors#element
        #
        def element_for(tag, identifier)
          find_watir_element("#{tag.to_s}(identifier)", Elements::Element, identifier, tag.to_s)
        end

        #
        # platform method to return an array of  PageObject::Elements::Element elements
        # See PageObject::Accessors#element
        #
        def elements_for(tag, identifier)
          find_watir_elements("#{tag.to_s}s(identifier)", Elements::Element, identifier, tag.to_s)
        end

        #
        # platform method to return a PageObject rooted at an element
        # See PageObject::Accessors#page_section
        #
        def page_for(identifier, page_class)
          find_watir_page(identifier, page_class)
        end

        #
        # platform method to return a collection of PageObjects rooted at elements
        # See PageObject::Accessors#page_sections
        #
        def pages_for(identifier, page_class)
          SectionCollection[*find_watir_pages(identifier, page_class)]
        end

        #
        # platform method to return a svg element
        #
        def svg_for(identifier)
          find_watir_element("element(identifier)", Elements::Element, identifier)
        end

        #
        # platform method to return an array of svg elements
        #
        def svgs_for(identifier)
          find_watir_elements("element(identifier)", Elements::Element, identifier)
        end

        #
        # platform method to retrieve the text for a b
        # See PageObject::Accessors#b
        #
        def b_text_for(identifier)
          process_watir_call("b(identifier).text", Elements::Bold, identifier, nil, 'b')
        end

        #
        # platform method to retrieve the b element
        # See PageObject::Accessors#b
        #
        def b_for(identifier)
          find_watir_element("b(identifier)", Elements::Bold, identifier, 'b')
        end

        #
        # platform method to retrieve an array of bs
        #
        def bs_for(identifier)
          find_watir_elements("bs(identifier)", Elements::Bold, identifier, 'b')
        end

        #
        # platform method to retrieve the text for a i
        # See PageObject::Accessors#i
        #
        def i_text_for(identifier)
          process_watir_call("i(identifier).text", Elements::Italic, identifier, nil, 'i')
        end

        #
        # platform method to retrieve the i element
        # See PageObject::Accessors#i
        #
        def i_for(identifier)
          find_watir_element("i(identifier)", Elements::Italic, identifier, 'i')
        end

        #
        # platform method to retrieve an array of is
        #
        def is_for(identifier)
          find_watir_elements("is(identifier)", Elements::Italic, identifier, 'i')
        end

        private

        def find_watir_elements(the_call, type, identifier, tag_name=nil)
          identifier, frame_identifiers = parse_identifiers(identifier, type, tag_name)
          elements = @browser.instance_eval "#{nested_frames(frame_identifiers)}#{the_call}"
          switch_to_default_content(frame_identifiers)
          elements.map { |element| type.new(element) }
        end

        def find_watir_element(the_call, type, identifier, tag_name=nil)
          identifier, frame_identifiers = parse_identifiers(identifier, type, tag_name)
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}#{the_call}"
          switch_to_default_content(frame_identifiers)
          type.new(element)
        end

        def find_watir_pages(identifier, page_class)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Element, 'element')
          elements = @browser.instance_eval "#{nested_frames(frame_identifiers)}elements(identifier)"
          switch_to_default_content(frame_identifiers)
          elements.map { |element| page_class.new(element) }
        end

        def find_watir_page(identifier, page_class)
          identifier, frame_identifiers = parse_identifiers(identifier, Elements::Element, 'element')
          element = @browser.instance_eval "#{nested_frames(frame_identifiers)}element(identifier)"
          switch_to_default_content(frame_identifiers)
          page_class.new(element)
        end

        def process_watir_call(the_call, type, identifier, value=nil, tag_name=nil)
          identifier, frame_identifiers = parse_identifiers(identifier, type, tag_name)
          value = @browser.instance_eval "#{nested_frames(frame_identifiers)}#{the_call}"
          switch_to_default_content(frame_identifiers)
          value
        end

        def parse_identifiers(identifier, element, tag_name=nil)
          new_identifiers = identifier.dup
          frame_identifiers = new_identifiers.delete(:frame)
          return new_identifiers, frame_identifiers
        end
        
        def nested_frames(frame_identifiers)
          return if frame_identifiers.nil?
          frame_str = ''
          frame_identifiers.each do |frame|
            type = frame.keys.first
            identifier = frame.values.first.map do |key, value|
              if value.is_a?(Regexp)
                ":#{key} => #{value.inspect}"
              elsif value.is_a? Integer
                ":#{key} => #{value}"
              else
                ":#{key} => '#{value}'"
              end
            end.join(', ')
            frame_str += "#{type.to_s}(#{identifier})."
          end
          frame_str
        end

        def switch_to_default_content(frame_identifiers)
          @browser.browser.wd.switch_to.default_content unless frame_identifiers.nil?
        end

        def switch_to_frame(frame_identifiers)
          unless frame_identifiers.nil?
            frame_identifiers.each do |frame|
              frame_id = frame.values.first
              value = frame_id.values.first
              @browser.wd.switch_to.frame(value)
            end
          end
        end

        def self.define_widget_multiple_accessor(base_element_tag, widget_class, widget_tag)
          send(:define_method, "#{widget_tag}s_for") do |identifier|
            find_watir_elements("#{base_element_tag}s(identifier)", widget_class, identifier, base_element_tag)
          end
        end

        def self.define_widget_singular_accessor(base_element_tag, widget_class, widget_tag)
          send(:define_method, "#{widget_tag}_for") do |identifier|
            find_watir_element("#{base_element_tag}(identifier)", widget_class, identifier, base_element_tag)
          end
        end
      end
    end
  end
end
