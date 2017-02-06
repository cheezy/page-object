require 'erb'
require 'page-object/locator_generator'

module PageObject
  #
  # Contains the class level methods that are inserted into your page objects
  # when you include the PageObject module.  These methods will generate another
  # set of methods that provide access to the elements on the web pages.
  #
  module Accessors

    #
    # Set some values that can be used within the class.  This is
    # typically used to provide values that help build dynamic urls in
    # the page_url method
    #
    # @param [Hash] the value to set the params
    #
    def params=(the_params)
      @params = the_params
    end

    #
    # Return the params that exist on this page class
    #
    def params
      @params ||= {}
    end

    #
    # Specify the url for the page.  A call to this method will generate a
    # 'goto' method to take you to the page.
    #
    # @param [String] the url for the page.
    # @param [Symbol] a method name to call to get the url
    #
    def page_url(url)
      define_method("goto") do
        platform.navigate_to self.page_url_value
      end

      define_method('page_url_value') do
        lookup = url.kind_of?(Symbol) ? self.send(url) : url
        erb = ERB.new(%Q{#{lookup}})
        merged_params = self.class.instance_variable_get("@merged_params")
        params = merged_params ? merged_params : self.class.params
        erb.result(binding)
      end
    end
    alias_method :direct_url, :page_url

    #
    # Creates a method that waits the expected_title of a page to match the actual.
    # @param [String] expected_title the literal expected title for the page
    # @param [Regexp] expected_title the expected title pattern for the page
    # @param [optional, Integer] timeout default value is nil - do not wait
    # @return [boolean]
    # @raise An exception if expected_title does not match actual title
    #
    # @example Specify 'Google' as the expected title of a page
    #   expected_title "Google"
    #   page.has_expected_title?
    #
    def wait_for_expected_title(expected_title, timeout=::PageObject.default_element_wait)
      define_method("wait_for_expected_title?") do
        error_message = lambda { "Expected title '#{expected_title}' instead of '#{title}'" }

        has_expected_title = (expected_title === title)
        wait_until(timeout, error_message.call) do
          has_expected_title = (expected_title === title)
        end unless has_expected_title

        raise error_message.call unless has_expected_title
        has_expected_title
      end
    end

    #
    # Creates a method that compares the expected_title of a page against the actual.
    # @param [String] expected_title the literal expected title for the page
    # @param [Regexp] expected_title the expected title pattern for the page
    # @return [boolean]
    # @raise An exception if expected_title does not match actual title
    #
    # @example Specify 'Google' as the expected title of a page
    #   expected_title "Google"
    #   page.has_expected_title?
    #
    def expected_title(expected_title)
      define_method("has_expected_title?") do
        page_title = title
        has_expected_title = (expected_title === page_title)
        raise "Expected title '#{expected_title}' instead of '#{page_title}'" unless has_expected_title
        has_expected_title
      end
    end

    #
    # Creates a method that provides a way to initialize a page based upon an expected element.
    # This is useful for pages that load dynamic content.
    # @param [Symbol] the name given to the element in the declaration
    # @param [optional, Integer] timeout default value is 5 seconds
    # @return [boolean]
    #
    # @example Specify a text box named :address expected on the page within 10 seconds
    #   expected_element(:address, 10)
    #   page.has_expected_element?
    #
    def expected_element(element_name, timeout=::PageObject.default_element_wait)
      define_method("has_expected_element?") do
        self.respond_to? "#{element_name}_element" and self.send("#{element_name}_element").when_present timeout
      end
    end

    #
    # Creates a method that provides a way to initialize a page based upon an expected element to become visible.
    # This is useful for pages that load dynamic content and might have hidden elements that are not shown.
    # @param [Symbol] the name given to the element in the declaration
    # @param [optional, Integer] timeout default value is 5 seconds
    # @param [optional, boolean] also check that element to be visible if set to true
    # @return [boolean]
    #
    # @example Specify a text box named :address expected on the page within 10 seconds
    #   expected_element_visible(:address, 10)
    #   page.has_expected_element_visible?
    #
    def expected_element_visible(element_name, timeout=::PageObject.default_element_wait, check_visible=false)
      define_method("has_expected_element_visible?") do
        self.respond_to? "#{element_name}_element" and self.send("#{element_name}_element").when_present timeout
        self.respond_to? "#{element_name}_element" and self.send("#{element_name}_element").when_visible timeout
      end
    end

    #
    # Identify an element as existing within a frame .  A frame parameter
    # is passed to the block and must be passed to the other calls to PageObject.
    # You can nest calls to in_frame by passing the frame to the next level.
    #
    # @example
    #   in_frame(:id => 'frame_id') do |frame|
    #     text_field(:first_name, :id => 'fname', :frame => frame)
    #   end
    #
    # @param [Hash] identifier how we find the frame.  The valid keys are:
    #   * :id
    #   * :index
    #   * :name
    #   * :regexp
    # @param frame passed from a previous call to in_frame.  Used to nest calls
    # @param block that contains the calls to elements that exist inside the frame.
    #
    def in_frame(identifier, frame=nil, &block)
      frame = frame.nil? ? [] : frame.dup
      frame << {frame: identifier}
      block.call(frame)
    end

    #
    # Identify an element as existing within an iframe.  A frame parameter
    # is passed to the block and must be passed to the other calls to PageObject.
    # You can nest calls to in_frame by passing the frame to the next level.
    #
    # @example
    #   in_iframe(:id => 'frame_id') do |frame|
    #     text_field(:first_name, :id => 'fname', :frame => frame)
    #   end
    #
    # @param [Hash] identifier how we find the frame.  The valid keys are:
    #   * :id
    #   * :index
    #   * :name
    #   * :regexp
    # @param frame passed from a previous call to in_iframe.  Used to nest calls
    # @param block that contains the calls to elements that exist inside the iframe.
    #
    def in_iframe(identifier, frame=nil, &block)
      frame = frame.nil? ? [] : frame.dup
      frame << {iframe: identifier}
      block.call(frame)
    end

    #
    # adds four methods to the page object - one to set text in a text field,
    # another to retrieve text from a text field, another to return the text
    # field element, another to check the text field's existence.
    #
    # @example
    #   text_field(:first_name, :id => "first_name")
    #   # will generate 'first_name', 'first_name=', 'first_name_element',
    #   # 'first_name?' methods
    #
    # @param  [String] the name used for the generated methods
    # @param [Hash] identifier how we find a text field.
    # @param optional block to be invoked when element method is called
    #
    def text_field(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'text_field_for', &block)
      define_method(name) do
        return platform.text_field_value_for identifier.clone unless block_given?
        self.send("#{name}_element").value
      end
      define_method("#{name}=") do |value|
        return platform.text_field_value_set(identifier.clone, value) unless block_given?
        self.send("#{name}_element").value = value
      end
    end

    #
    # adds three methods to the page object - one to get the text from a hidden field,
    # another to retrieve the hidden field element, and another to check the hidden
    # field's existence.
    #
    # @example
    #   hidden_field(:user_id, :id => "user_identity")
    #   # will generate 'user_id', 'user_id_element' and 'user_id?' methods
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a hidden field.
    # @param optional block to be invoked when element method is called
    #
    def hidden_field(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'hidden_field_for', &block)
      define_method(name) do
        return platform.hidden_field_value_for identifier.clone unless block_given?
        self.send("#{name}_element").value
      end
    end
    alias_method :hidden, :hidden_field

    #
    # adds four methods to the page object - one to set text in a text area,
    # another to retrieve text from a text area, another to return the text
    # area element, and another to check the text area's existence.
    #
    # @example
    #   text_area(:address, :id => "address")
    #   # will generate 'address', 'address=', 'address_element',
    #   # 'address?' methods
    #
    # @param  [String] the name used for the generated methods
    # @param [Hash] identifier how we find a text area.
    # @param optional block to be invoked when element method is called
    #
    def text_area(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'text_area_for', &block)
      define_method(name) do
        return platform.text_area_value_for identifier.clone unless block_given?
        self.send("#{name}_element").value
      end
      define_method("#{name}=") do |value|
        return platform.text_area_value_set(identifier.clone, value) unless block_given?
        self.send("#{name}_element").value = value
      end
    end
    alias_method :textarea, :text_area

    #
    # adds five methods - one to select an item in a drop-down,
    # another to fetch the currently selected item text, another
    # to retrieve the select list element, another to check the
    # drop down's existence and another to get all the available options
    # to select from.
    #
    # @example
    #   select_list(:state, :id => "state")
    #   # will generate 'state', 'state=', 'state_element', 'state?', "state_options" methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a select list.
    # @param optional block to be invoked when element method is called
    #
    def select_list(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'select_list_for', &block)
      define_method(name) do
        return platform.select_list_value_for identifier.clone unless block_given?
        self.send("#{name}_element").value
      end
      define_method("#{name}=") do |value|
        return platform.select_list_value_set(identifier.clone, value) unless block_given?
        self.send("#{name}_element").select(value)
      end
      define_method("#{name}_options") do
        element = self.send("#{name}_element")
        (element && element.options) ? element.options.collect(&:text) : []
      end
    end
    alias_method :select, :select_list

    #
    # adds three methods - one to select a link, another
    # to return a PageObject::Elements::Link object representing
    # the link, and another that checks the link's existence.
    #
    # @example
    #   link(:add_to_cart, :text => "Add to Cart")
    #   # will generate 'add_to_cart', 'add_to_cart_element', and 'add_to_cart?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a link.
    # @param optional block to be invoked when element method is called
    #
    def link(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'link_for', &block)
      define_method(name) do
        return platform.click_link_for identifier.clone unless block_given?
        self.send("#{name}_element").click
      end
    end
    alias_method :a, :link

    #
    # adds five methods - one to check, another to uncheck, another
    # to return the state of a checkbox, another to return
    # a PageObject::Elements::CheckBox object representing the checkbox, and
    # a final method to check the checkbox's existence.
    #
    # @example
    #   checkbox(:active, :name => "is_active")
    #   # will generate 'check_active', 'uncheck_active', 'active_checked?',
    #   # 'active_element', and 'active?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a checkbox.
    # @param optional block to be invoked when element method is called
    #
    def checkbox(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'checkbox_for', &block)
      define_method("check_#{name}") do
        return platform.check_checkbox(identifier.clone) unless block_given?
        self.send("#{name}_element").check
      end
      define_method("uncheck_#{name}") do
        return platform.uncheck_checkbox(identifier.clone) unless block_given?
        self.send("#{name}_element").uncheck
      end
      define_method("#{name}_checked?") do
        return platform.checkbox_checked?(identifier.clone) unless block_given?
        self.send("#{name}_element").checked?
      end
    end

    #
    # adds four methods - one to select, another to return if a radio button
    # is selected, another method to return a PageObject::Elements::RadioButton
    # object representing the radio button element, and another to check
    # the radio button's existence.
    #
    # @example
    #   radio_button(:north, :id => "north")
    #   # will generate 'select_north', 'north_selected?',
    #   # 'north_element', and 'north?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a radio button.
    # @param optional block to be invoked when element method is called
    #
    def radio_button(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'radio_button_for', &block)
      define_method("select_#{name}") do
        return platform.select_radio(identifier.clone) unless block_given?
        self.send("#{name}_element").select
      end
      define_method("#{name}_selected?") do
        return platform.radio_selected?(identifier.clone) unless block_given?
        self.send("#{name}_element").selected?
      end
    end
    alias_method :radio, :radio_button

    #
    # adds five methods to help interact with a radio button group -
    # a method to select a radio button in the group by given value/text,
    # a method to return the values of all radio buttons in the group, a method
    # to return if a radio button in the group is selected (will return
    # the text of the selected radio button, if true), a method to return
    # an array of PageObject::Elements::RadioButton objects representing
    # the radio button group, and finally a method to check the existence
    # of the radio button group.
    #
    # @example
    # radio_button_group(:color, :name => "preferred_color")
    # will generate 'select_color', 'color_values', 'color_selected?',
    # 'color_elements', and 'color?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] shared identifier for the radio button group. Typically, a 'name' attribute.
    # The valid keys are:
    # * :name
    #
    def radio_button_group(name, identifier)
      define_method("select_#{name}") do |value|
        platform.radio_buttons_for(identifier.clone).each do |radio_elem|
          if radio_elem.value == value
            return radio_elem.select
          end
        end
      end
      define_method("#{name}_values") do
        result = []
        platform.radio_buttons_for(identifier.clone).each do |radio_elem|
          result << radio_elem.value
        end
        return result
      end
      define_method("#{name}_selected?") do
        platform.radio_buttons_for(identifier.clone).each do |radio_elem|
          return radio_elem.value if radio_elem.selected?
        end
        return false
      end
      define_method("#{name}_elements") do
        return platform.radio_buttons_for(identifier.clone)
      end
      define_method("#{name}?") do
        return platform.radio_buttons_for(identifier.clone).any?
      end
    end
    alias_method :radio_group, :radio_button_group

    #
    # adds three methods - one to click a button, another to
    # return the button element, and another to check the button's existence.
    #
    # @example
    #   button(:purchase, :id => 'purchase')
    #   # will generate 'purchase', 'purchase_element', and 'purchase?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a button.
    # @param optional block to be invoked when element method is called
    #
    def button(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'button_for', &block)
      define_method(name) do
        return platform.click_button_for identifier.clone unless block_given?
        self.send("#{name}_element").click
      end
    end

    #
    # adds three methods - one to retrieve the text from a div,
    # another to return the div element, and another to check the div's existence.
    #
    # @example
    #   div(:message, :id => 'message')
    #   # will generate 'message', 'message_element', and 'message?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a div.
    # @param optional block to be invoked when element method is called
    #
    def div(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'div_for', &block)
      define_method(name) do
        return platform.div_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end

    #
    # adds three methods - one to retrieve the text from a span,
    # another to return the span element, and another to check the span's existence.
    #
    # @example
    #   span(:alert, :id => 'alert')
    #   # will generate 'alert', 'alert_element', and 'alert?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a span.
    # @param optional block to be invoked when element method is called
    #
    def span(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'span_for', &block)
      define_method(name) do
        return platform.span_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end

    #
    # adds three methods - one to return the text for the table, one
    # to  retrieve the table element, and another to
    # check the table's existence.
    #
    # @example
    #   table(:cart, :id => 'shopping_cart')
    #   # will generate a 'cart', 'cart_element' and 'cart?' method
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a table.
    # @param optional block to be invoked when element method is called
    #
    def table(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'table_for', &block)
      define_method(name) do
        return platform.table_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end

    #
    # adds three methods - one to retrieve the text from a table cell,
    # another to return the table cell element, and another to check the cell's
    # existence.
    #
    # @example
    #   cell(:total, :id => 'total_cell')
    #   # will generate 'total', 'total_element', and 'total?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a cell.
    # @param optional block to be invoked when element method is called
    #
    def cell(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'cell_for', &block)
      define_method("#{name}") do
        return platform.cell_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end
    alias_method :td, :cell


    #
    # adds three methods - one to retrieve the text from a table row,
    # another to return the table row element, and another to check the row's
    # existence.
    #
    # @example
    #   row(:sums, :id => 'sum_row')
    #   # will generate 'sums', 'sums_element', and 'sums?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a cell.
    # @param optional block to be invoked when element method is called
    #
    def row(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'row_for', &block)
      define_method("#{name}") do
        return platform.row_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end

    #
    # adds three methods - one to retrieve the image element, another to
    # check the load status of the image, and another to check the
    # image's existence.
    #
    # @example
    #   image(:logo, :id => 'logo')
    #   # will generate 'logo_element', 'logo_loaded?', and 'logo?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an image.
    # @param optional block to be invoked when element method is called
    #
    def image(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'image_for', &block)
      define_method("#{name}_loaded?") do
        return platform.image_loaded_for identifier.clone unless block_given?
        self.send("#{name}_element").loaded?
      end
    end
    alias_method :img, :image

    #
    # adds two methods - one to retrieve the form element, and another to
    # check the form's existence.
    #
    # @example
    #   form(:login, :id => 'login')
    #   # will generate 'login_element' and 'login?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a form.
    # @param optional block to be invoked when element method is called
    #
    def form(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'form_for', &block)
    end

    #
    # adds three methods - one to retrieve the text from a list item,
    # another to return the list item element, and another to check the list item's
    # existence.
    #
    # @example
    #   list_item(:item_one, :id => 'one')
    #   # will generate 'item_one', 'item_one_element', and 'item_one?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a list item.
    # @param optional block to be invoked when element method is called
    #
    def list_item(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'list_item_for', &block)
      define_method(name) do
        return platform.list_item_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end
    alias_method :li, :list_item

    #
    # adds three methods - one to return the text within the unordered
    # list, one to retrieve the unordered list element, and another to
    # check it's existence.
    #
    # @example
    #   unordered_list(:menu, :id => 'main_menu')
    #   # will generate 'menu', 'menu_element' and 'menu?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an unordered list.
    # @param optional block to be invoked when element method is called
    #
    def unordered_list(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'unordered_list_for', &block)
      define_method(name) do
        return platform.unordered_list_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end
    alias_method :ul, :unordered_list

    #
    # adds three methods - one to return the text within the ordered
    # list, one to retrieve the ordered list element, and another to
    # test it's existence.
    #
    # @example
    #   ordered_list(:top_five, :id => 'top')
    #   # will generate 'top_five', 'top_five_element' and 'top_five?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an ordered list.
    # @param optional block to be invoked when element method is called
    #
    def ordered_list(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'ordered_list_for', &block)
      define_method(name) do
        return platform.ordered_list_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end
    alias_method :ol, :ordered_list

    #
    # adds three methods - one to retrieve the text of a h1 element, another to
    # retrieve a h1 element, and another to check for it's existence.
    #
    # @example
    #   h1(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a H1.  You can use a multiple parameters
    #   by combining of any of the following except xpath.
    # @param optional block to be invoked when element method is called
    #
    def h1(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier,'h1_for', &block)
      define_method(name) do
        return platform.h1_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end

    #
    # adds three methods - one to retrieve the text of a h2 element, another
    # to retrieve a h2 element, and another to check for it's existence.
    #
    # @example
    #   h2(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a H2.
    # @param optional block to be invoked when element method is called
    #
    def h2(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'h2_for', &block)
      define_method(name) do
        return platform.h2_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end

    #
    # adds three methods - one to retrieve the text of a h3 element,
    # another to return a h3 element, and another to check for it's existence.
    #
    # @example
    #   h3(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a H3.
    # @param optional block to be invoked when element method is called
    #
    def h3(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'h3_for', &block)
      define_method(name) do
        return platform.h3_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end

    #
    # adds three methods - one to retrieve the text of a h4 element,
    # another to return a h4 element, and another to check for it's existence.
    #
    # @example
    #   h4(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a H4.
    # @param optional block to be invoked when element method is called
    #
    def h4(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'h4_for', &block)
      define_method(name) do
        return platform.h4_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end

    #
    # adds three methods - one to retrieve the text of a h5 element,
    # another to return a h5 element, and another to check for it's existence.
    #
    # @example
    #   h5(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a H5.
    # @param optional block to be invoked when element method is called
    #
    def h5(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'h5_for', &block)
      define_method(name) do
        return platform.h5_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end

    #
    # adds three methods - one to retrieve the text of a h6 element,
    # another to return a h6 element, and another to check for it's existence.
    #
    # @example
    #   h6(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a H6.
    # @param optional block to be invoked when element method is called
    #
    def h6(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'h6_for', &block)
      define_method(name) do
        return platform.h6_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end

    #
    # adds three methods - one to retrieve the text of a paragraph, another
    # to retrieve a paragraph element, and another to check the paragraph's existence.
    #
    # @example
    #   paragraph(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a paragraph.
    # @param optional block to be invoked when element method is called
    #
    def paragraph(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'paragraph_for', &block)
      define_method(name) do
        return platform.paragraph_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end
    alias_method :p, :paragraph

    #
    # adds three methods - one to set the file for a file field, another to retrieve
    # the file field element, and another to check it's existence.
    #
    # @example
    #   file_field(:the_file, :id => 'file_to_upload')
    #   # will generate 'the_file=', 'the_file_element', and 'the_file?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a file_field.
    # @param optional block to be invoked when element method is called
    #
    def file_field(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'file_field_for', &block)
      define_method("#{name}=") do |value|
        return platform.file_field_value_set(identifier.clone, value) unless block_given?
        self.send("#{name}_element").value = value
      end
    end

    #
    # adds three methods - one to retrieve the text from a label,
    # another to return the label element, and another to check the label's existence.
    #
    # @example
    #   label(:message, :id => 'message')
    #   # will generate 'message', 'message_element', and 'message?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a label.
    # @param optional block to be invoked when element method is called
    #
    def label(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'label_for', &block)
      define_method(name) do
        return platform.label_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end

    #
    # adds three methods - one to click the area,
    # another to return the area element, and another to check the area's existence.
    #
    # @example
    #   area(:message, :id => 'message')
    #   # will generate 'message', 'message_element', and 'message?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an area.
    # @param optional block to be invoked when element method is called
    #
    def area(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'area_for', &block)
      define_method(name) do
        return platform.click_area_for identifier.clone unless block_given?
        self.send("#{name}_element").click
      end
    end

    #
    # adds two methods - one to return the canvas element and another to check
    # the canvas's existence.
    #
    # @example
    #   canvas(:my_canvas, :id => 'canvas_id')
    #   # will generate 'my_canvas_element' and 'my_canvas?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a canvas.
    # @param optional block to be invoked when element method is called
    #
    def canvas(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'canvas_for', &block)
    end

    #
    # adds two methods - one to return the audio element and another to check
    # the audio's existence.
    #
    # @example
    #   audio(:acdc, :id => 'audio_id')
    #   # will generate 'acdc_element' and 'acdc?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an audio element.
    # @param optional block to be invoked when element method is called
    #
    def audio(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'audio_for', &block)
    end

    #
    # adds two methods - one to return the video element and another to check
    # the video's existence.
    #
    # @example
    #   video(:movie, :id => 'video_id')
    #   # will generate 'movie_element' and 'movie?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a video element.
    # @param optional block to be invoked when element method is called
    #
    def video(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'video_for', &block)
    end

    #
    # adds three methods - one to retrieve the text of a b element, another to
    # retrieve a b element, and another to check for it's existence.
    #
    # @example
    #   b(:bold, :id => 'title')
    #   # will generate 'bold', 'bold_element', and 'bold?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a b.
    # @param optional block to be invoked when element method is called
    #
    def b(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier,'b_for', &block)
      define_method(name) do
        return platform.b_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end

    #
    # adds three methods - one to retrieve the text of a i element, another to
    # retrieve a i element, and another to check for it's existence.
    #
    # @example
    #   i(:italic, :id => 'title')
    #   # will generate 'italic', 'italic_element', and 'italic?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a i.
    # @param optional block to be invoked when element method is called
    #
    def i(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier,'i_for', &block)
      define_method(name) do
        return platform.i_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
    end
    alias_method :icon, :i

    #
    # adds two methods - one to retrieve a svg, and another to check
    # the svg's existence.
    #
    # @example
    #   svg(:circle, :id => 'circle')
    #   # will generate 'circle_element', and 'circle?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a svg.
    # @param optional block to be invoked when element method is called
    #
    def svg(name, identifier={:index => 0}, &block)
      standard_methods(name, identifier, 'svg_for', &block)
    end


    #
    # adds three methods - one to retrieve the text of an element, another
    # to retrieve an element, and another to check the element's existence.
    #
    # @example
    #   element(:title, :header, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Symbol] the name of the tag for the element
    # @param [Hash] identifier how we find an element.
    # @param optional block to be invoked when element method is called
    #
    def element(name, tag=:element, identifier={ :index => 0 }, &block)
      #
      # sets tag as element if not defined
      #
      if tag.is_a?(Hash)
        identifier = tag
        tag        = :element
      end

      standard_methods(name, identifier, 'element_for', &block)

      define_method("#{name}") do
        element = self.send("#{name}_element")

        %w(Button TextField Radio Hidden CheckBox FileField).each do |klass|
          next unless element.element.class.to_s  == "Watir::#{klass}"
          self.class.send(klass.gsub(/(.)([A-Z])/,'\1_\2').downcase, name, identifier, &block)
          return self.send name
        end
        element.text
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.element_for(tag, identifier.clone)
      end
      define_method("#{name}?") do
        self.send("#{name}_element").exists?
      end
      define_method("#{name}=") do |value|
        element = self.send("#{name}_element")

        klass = case element.element
                when Watir::TextField
                  'text_field'
                when Watir::TextArea
                  'text_area'
                when Watir::Select
                  'select_list'
                when Watir::FileField
                  'file_field'
                else
                  raise "Can not set a #{element.element} element with #="
                end
        self.class.send(klass, name, identifier, &block)
        self.send("#{name}=", value)
      end
    end

    #
    # adds a method to return a collection of generic Element objects
    # for a specific tag.
    #
    # @example
    #   elements(:title, :header, :id => 'title')
    #   # will generate ''title_elements'
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Symbol] the name of the tag for the element
    # @param [Hash] identifier how we find an element.
    # @param optional block to be invoked when element method is called
    #
    def elements(name, tag=:element, identifier={:index => 0}, &block)
      #
      # sets tag as element if not defined
      #
      if tag.is_a?(Hash)
        identifier = tag
        tag        = :element
      end

      define_method("#{name}_elements") do
        return call_block(&block) if block_given?
        platform.elements_for(tag, identifier.clone)
      end
    end

    #
    # adds a method to return a page object rooted at an element
    #
    # @example
    #   page_section(:navigation_bar, NavigationBar, :id => 'nav-bar')
    #   # will generate 'navigation_bar'
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Class] the class to instantiate for the element
    # @param [Hash] identifier how we find an element.
    #
    def page_section(name, section_class, identifier)
      define_method(name) do
        platform.page_for(identifier, section_class)
      end
    end

    #
    # adds a method to return a collection of page objects rooted at elements
    #
    # @example
    #   page_sections(:articles, Article, :class => 'article')
    #   # will generate 'articles'
    #
    # @param [Symbol] the name used for the generated method
    # @param [Class] the class to instantiate for each element
    # @param [Hash] identifier how we find an element.
    #
    def page_sections(name, section_class, identifier)
      define_method(name) do
        platform.pages_for(identifier, section_class)
      end
    end

    #
    # methods to generate accessors for types that follow the same
    # pattern as element
    #
    # @example
    #   article(:my_article, :id => "article_id")
    #   will generate 'my_article', 'my_article_element' and 'my_article?'
    #   articles(:my_article, :id => 'article_id')
    #   will generate 'my_article_elements'
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Symbol] the name of the tag for the element
    # @param [Hash] identifier how we find an element.
    # @param optional block to be invoked when element method is called
    #
    LocatorGenerator::BASIC_ELEMENTS.each do |tag|
      define_method(tag) do |name, *identifier, &block|
        identifier = identifier[0] ? identifier[0] : {:index => 0}
        element(name, tag, identifier, &block)
      end
      define_method("#{tag}s") do |name, *identifier, &block|
        identifier = identifier[0] ? identifier[0] : {:index => 0}
        elements(name, tag, identifier, &block)
      end unless tag == :param
    end

    def standard_methods(name, identifier, method, &block)
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.send(method, identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.send(method, identifier.clone).exists?
      end
    end

    #
    # adds a method that will return an indexed property.  The property will respond to
    # the [] method with an object that has a set of normal page_object properties that
    # correspond to the definitions included in the identifier_list parameter, with the
    # "what" of the "how and what" substituted based on the index provided to the []
    # method.
    #
    # @example
    #   indexed_property(:title, [
    #     [:text_field,  :field_1,   :id => 'table[%s].field_1'],
    #     [:button,      :button_1,  :id => 'table[%s].button_1'],
    #     [:text_field,  :field_2,   :name => 'table[%s].field_2']
    #   ])
    #   # will generate a title method that responds to [].  title['foo'] will return an object
    #   # that responds to the normal methods expected for two text_fields and a button with the
    #   # given names, using the given how and what with 'foo' substituted for the %s.  title[123]
    #   # will do the same, using the integer 123 instead.
    #
    # @param [Symbol] the name used for the generated method
    # @param [Array] definitions an array of definitions to define on the indexed property.  Each
    #   entry in the array should contain two symbols and a hash, corresponding to one of the standard
    #   page_object properties with a single substitution marker in each value in the hash,
    #   e.g. [:text_field, :field_1, :id => 'table[%s].field_1']
    #
    def indexed_property (name, identifier_list)
      define_method("#{name}") do
        IndexedProperties::TableOfElements.new(@browser, identifier_list)
      end
    end

    #
    # methods to fetch multiple elements of the same type
    #
    # adds a method to the page object to return all of the matching elements
    #
    # @example
    #   text_fields(:first_name, :id => "first_name")
    #   # will generate 'first_name_elements'
    #
    # @param  [String] the name used for the generated methods
    # @param [Hash] identifier how we find a text field.  You can use a multiple parameters
    #   by combining of any of the following except xpath.  The valid
    #   keys are the same ones supported by the standard methods.
    # @param optional block to be invoked when element method is called
    #
    idx = LocatorGenerator::ADVANCED_ELEMENTS.find_index { |type| type == :checkbox }
    elements = LocatorGenerator::ADVANCED_ELEMENTS.clone
    elements[idx] = :checkboxe
    elements.each do |method_name|
      define_method("#{method_name}s") do |name, *identifier, &block|
        define_method("#{name}_elements") do
          return call_block(&block) unless block.nil?
          platform_method = (method_name == :checkboxe) ? 'checkboxs_for' : "#{method_name.to_s}s_for"
          platform.send platform_method, (identifier.first ? identifier.first.clone : {})
        end
      end
    end
  end
end
