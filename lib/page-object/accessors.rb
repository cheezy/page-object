module PageObject
  #
  # Contains the class level methods that are inserted into your page objects
  # when you include the PageObject module.  These methods will generate another
  # set of methods that provide access to the elements on the web pages.
  #
  # @see PageObject::WatirPageObject for the watir implementation of the platform delegate
  # @see PageObject::SeleniumPageObject for the selenium implementation of the platform delegate
  #
  module Accessors

    #
    # Specify the url for the page.  A call to this method will generate a
    # 'goto' method to take you to the page.
    #
    # @param [String] the url for the page.
    # @param [Symbol] a method name to call to get the url
    #
    def page_url(url)
      define_method("goto") do
        url = url.kind_of?(Symbol) ? self.send(url) : url
        platform.navigate_to url
      end
    end
    alias_method :direct_url, :page_url

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
        has_expected_title = expected_title === title
        raise "Expected title '#{expected_title}' instead of '#{title}'" unless has_expected_title
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
    def expected_element(element_name, timeout=5)
      define_method("has_expected_element?") do
        self.respond_to? "#{element_name}_element" and self.send("#{element_name}_element").when_present timeout
      end
    end

    #
    # Identify an element as existing within a frame or iframe.  A frame parameter
    # is passed to the block and must be passed to the other calls to PageObject.
    # You can nest calls to in_frame by passing the frame to the next level.
    #
    # @example
    #   in_frame(:id => 'frame_id') do |frame|
    #     text_field(:first_name, :id => 'fname', :frame => frame)
    #   end
    #
    # @param [Hash] identifier how we find the frame.  The valid keys are:
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    # @param frame passed from a previous call to in_frame.  Used to nest calls
    # @param block that contains the calls to elements that exist inside the frame.
    #
    def in_frame(identifier, frame=nil, &block)
      frame = [] if frame.nil?
      frame << identifier
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
    # @param [Hash] identifier how we find a text field.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :css => Selenium only
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :label => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :title => Watir and Selenium
    #   * :value => Watir only
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def text_field(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.text_field_value_for identifier.clone unless block_given?
        self.send("#{name}_element").value
      end
      define_method("#{name}=") do |value|
        return platform.text_field_value_set(identifier.clone, value) unless block_given?
        self.send("#{name}_element").value = value
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.text_field_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.text_field_for(identifier.clone).exists?
      end
      alias_method "#{name}_text_field".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a hidden field.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :value => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def hidden_field(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.hidden_field_value_for identifier.clone unless block_given?
        self.send("#{name}_element").value
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.hidden_field_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.hidden_field_for(identifier.clone).exists?
      end
      alias_method "#{name}_hidden_field".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a text area.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def text_area(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.text_area_value_for identifier.clone unless block_given?
        self.send("#{name}_element").value
      end
      define_method("#{name}=") do |value|
        return platform.text_area_value_set(identifier.clone, value) unless block_given?
        self.send("#{name}_element").value = value
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.text_area_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.text_area_for(identifier.clone).exists?
      end
      alias_method "#{name}_text_area".to_sym, "#{name}_element".to_sym
    end
    alias_method :textarea, :text_area

    #
    # adds four methods - one to select an item in a drop-down,
    # another to fetch the currently selected item text, another
    # to retrieve the select list element, and another to check the
    # drop down's existence.
    #
    # @example
    #   select_list(:state, :id => "state")
    #   # will generate 'state', 'state=', 'state_element', 'state?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a select list.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir only
    #   * :value => Watir only
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def select_list(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.select_list_value_for identifier.clone unless block_given?
        self.send("#{name}_element").value
      end
      define_method("#{name}=") do |value|
        return platform.select_list_value_set(identifier.clone, value) unless block_given?
        self.send("#{name}_element").select(value)
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.select_list_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.select_list_for(identifier.clone).exists?
      end
      alias_method "#{name}_select_list".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a link.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :css => Watir and Selenium
    #   * :href => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :link => Watir and Selenium
    #   * :link_text => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :title => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def link(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.click_link_for identifier.clone unless block_given?
        self.send("#{name}_element").click
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.link_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.link_for(identifier.clone).exists?
      end
      alias_method "#{name}_link".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a checkbox.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :value => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def checkbox(name, identifier={:index => 0}, &block)
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
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.checkbox_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.checkbox_for(identifier.clone).exists?
      end
      alias_method "#{name}_checkbox".to_sym, "#{name}_element".to_sym
    end

    #
    # adds five methods - one to select, another to clear,
    # another to return if a radio button is selected,
    # another method to return a PageObject::Elements::RadioButton
    # object representing the radio button element, and another to check
    # the radio button's existence.
    #
    # @example
    #   radio_button(:north, :id => "north")
    #   # will generate 'select_north', 'clear_north', 'north_selected?',
    #   # 'north_element', and 'north?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a radio button.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :value => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def radio_button(name, identifier={:index => 0}, &block)
      define_method("select_#{name}") do
        return platform.select_radio(identifier.clone) unless block_given?
        self.send("#{name}_element").select
      end
      define_method("clear_#{name}") do
        return platform.clear_radio(identifier.clone) unless block_given?
        self.send("#{name}_element").clear
      end
      define_method("#{name}_selected?") do
        return platform.radio_selected?(identifier.clone) unless block_given?
        self.send("#{name}_element").selected?
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.radio_button_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.radio_button_for(identifier.clone).exists?
      end
      alias_method "#{name}_radio_button".to_sym, "#{name}_element".to_sym
    end
    alias_method :radio, :radio_button

    #
    # adds three methods - one to click a button, another to
    # return the button element, and another to check the button's existence.
    #
    # @example
    #   button(:purchase, :id => 'purchase')
    #   # will generate 'purchase', 'purchase_element', and 'purchase?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a button.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :css => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :value => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #   * :src => Watir and Selenium (input type=image only)
    #   * :alt => Watir and Selenium (input type=image only)
    # @param optional block to be invoked when element method is called
    #
    def button(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.click_button_for identifier.clone unless block_given?
        self.send("#{name}_element").click
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.button_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.button_for(identifier.clone).exists?
      end
      alias_method "#{name}_button".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a div.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :title => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def div(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.div_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.div_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.div_for(identifier.clone).exists?
      end
      alias_method "#{name}_div".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a span.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :title => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def span(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.span_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.span_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.span_for(identifier.clone).exists?
      end
      alias_method "#{name}_span".to_sym, "#{name}_element".to_sym
    end

    #
    # adds two methods - one to retrieve the table element, and another to
    # check the table's existence.  The existence method does not work
    # on Selenium so it should not be called.
    #
    # @example
    #   table(:cart, :id => 'shopping_cart')
    #   # will generate a 'cart_element' and 'cart?' method
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find a table.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def table(name, identifier={:index => 0}, &block)
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.table_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.table_for(identifier.clone).exists?
      end
      alias_method "#{name}_table".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a cell.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def cell(name, identifier={:index => 0}, &block)
      define_method("#{name}") do
        return platform.cell_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.cell_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.cell_for(identifier.clone).exists?
      end
      alias_method "#{name}_cell".to_sym, "#{name}_element".to_sym
    end
    alias_method :td, :cell

    #
    # adds two methods - one to retrieve the image element, and another to
    # check the image's existence.
    #
    # @example
    #   image(:logo, :id => 'logo')
    #   # will generate 'logo_element' and 'logo?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an image.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :alt => Watir and Selenium
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :src => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def image(name, identifier={:index => 0}, &block)
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.image_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.image_for(identifier.clone).exists?
      end
      alias_method "#{name}_image".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a form.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :action => Watir and Selenium
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def form(name, identifier={:index => 0}, &block)
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.form_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.form_for(identifier.clone).exists?
      end
      alias_method "#{name}_form".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a list item.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def list_item(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.list_item_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.list_item_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.list_item_for(identifier.clone).exists?
      end
      alias_method "#{name}_list_item".to_sym, "#{name}_element".to_sym
    end
    alias_method :li, :list_item

    #
    # adds two methods - one to retrieve the unordered list element, and another to
    # check it's existence.
    #
    # @example
    #   unordered_list(:menu, :id => 'main_menu')
    #   # will generate 'menu_element' and 'menu?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an unordered list.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def unordered_list(name, identifier={:index => 0}, &block)
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.unordered_list_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.unordered_list_for(identifier.clone).exists?
      end
      alias_method "#{name}_unordered_list".to_sym, "#{name}_element".to_sym
    end
    alias_method :ul, :unordered_list

    #
    # adds two methods - one to retrieve the ordered list element, and another to
    # test it's existence.
    #
    # @example
    #   ordered_list(:top_five, :id => 'top')
    #   # will generate 'top_five_element' and 'top_five?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an ordered list.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def ordered_list(name, identifier={:index => 0}, &block)
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.ordered_list_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.ordered_list_for(identifier.clone).exists?
      end
      alias_method "#{name}_ordered_list".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a H1.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def h1(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.h1_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.h1_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.h1_for(identifier.clone).exists?
      end
      alias_method "#{name}_h1".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a H2.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def h2(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.h2_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.h2_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.h2_for(identifier.clone).exists?
      end
      alias_method "#{name}_h2".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a H3.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def h3(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.h3_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.h3_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.h3_for(identifier.clone).exists?
      end
      alias_method "#{name}_h3".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a H4.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def h4(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.h4_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.h4_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.h4_for(identifier.clone).exists?
      end
      alias_method "#{name}_h4".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a H5.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def h5(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.h5_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.h5_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.h5_for(identifier.clone).exists?
      end
      alias_method "#{name}_h5".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a H6.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def h6(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.h6_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.h6_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.h6_for(identifier.clone).exists?
      end
      alias_method "#{name}_h6".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a paragraph.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def paragraph(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.paragraph_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.paragraph_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.paragraph_for(identifier.clone).exists?
      end
      alias_method "#{name}_paragraph".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find a file_field.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :title => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def file_field(name, identifier={:index => 0}, &block)
      define_method("#{name}=") do |value|
        return platform.file_field_value_set(identifier.clone, value) unless block_given?
        self.send("#{name}_element").value = value
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.file_field_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.file_field_for(identifier.clone).exists?
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
    # @param [Hash] identifier how we find a label.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def label(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.label_text_for identifier.clone unless block_given?
        self.send("#{name}_element").text
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.label_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.label_for(identifier.clone).exists?
      end
      alias_method "#{name}_label".to_sym, "#{name}_element".to_sym
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
    # @param [Hash] identifier how we find an area.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def area(name, identifier={:index => 0}, &block)
      define_method(name) do
        return platform.click_area_for identifier.clone unless block_given?
        self.send("#{name}_element").click
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.area_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.area_for(identifier.clone).exists?
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
    # @param [Hash] identifier how we find a canvas.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def canvas(name, identifier={:index => 0}, &block)
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.canvas_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.canvas_for(identifier.clone).exists?
      end
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
    # @param [Hash] identifier how we find an audio element.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def audio(name, identifier={:index => 0}, &block)
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.audio_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.audio_for(identifier.clone).exists?
      end
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
    # @param [Hash] identifier how we find a video element.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def video(name, identifier={:index => 0}, &block)
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.video_for(identifier.clone)
      end
      define_method("#{name}?") do
        return call_block(&block).exists? if block_given?
        platform.video_for(identifier.clone).exists?
      end
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
    # @param [Hash] identifier how we find an element.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def element(name, tag, identifier={:index => 0}, &block)
      define_method("#{name}") do
        self.send("#{name}_element").text
      end
      define_method("#{name}_element") do
        return call_block(&block) if block_given?
        platform.element_for(tag, identifier.clone)
      end
      define_method("#{name}?") do
        self.send("#{name}_element").exists?
      end
    end

    #
    # adds three methods - one to retrieve the text of an abbr, another
    # to retrieve an  abbr, and another to check the abbr's existence.
    #
    # @example
    #   abbr(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an abbr.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when abbr method is called
    #
    def abbr(name, identifier={:index => 0}, &block)
      element(name, :abbr, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an address, another
    # to retrieve an  address, and another to check the address's existence.
    #
    # @example
    #   address(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an address.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when address method is called
    #
    def address(name, identifier={:index => 0}, &block)
      element(name, :address, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an article, another
    # to retrieve an  article, and another to check the article's existence.
    #
    # @example
    #   article(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an article.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when article method is called
    #
    def article(name, identifier={:index => 0}, &block)
      element(name, :article, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an aside, another
    # to retrieve an  aside, and another to check the aside's existence.
    #
    # @example
    #   aside(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an aside.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when aside method is called
    #
    def aside(name, identifier={:index => 0}, &block)
      element(name, :aside, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an bdi, another
    # to retrieve an  bdi, and another to check the bdi's existence.
    #
    # @example
    #   bdi(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an bdi.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when bdi method is called
    #
    def bdi(name, identifier={:index => 0}, &block)
      element(name, :bdi, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an bdo, another
    # to retrieve an  bdo, and another to check the bdo's existence.
    #
    # @example
    #   bdo(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an bdo.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when bdo method is called
    #
    def bdo(name, identifier={:index => 0}, &block)
      element(name, :bdo, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an cite, another
    # to retrieve an  cite, and another to check the cite's existence.
    #
    # @example
    #   cite(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an cite.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when cite method is called
    #
    def cite(name, identifier={:index => 0}, &block)
      element(name, :cite, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an code, another
    # to retrieve an  code, and another to check the code's existence.
    #
    # @example
    #   code(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an code.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when code method is called
    #
    def code(name, identifier={:index => 0}, &block)
      element(name, :code, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an dd, another
    # to retrieve an  dd, and another to check the dd's existence.
    #
    # @example
    #   dd(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an dd.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when dd method is called
    #
    def dd(name, identifier={:index => 0}, &block)
      element(name, :dd, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an dfn, another
    # to retrieve an  dfn, and another to check the dfn's existence.
    #
    # @example
    #   dfn(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an dfn.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when dfn method is called
    #
    def dfn(name, identifier={:index => 0}, &block)
      element(name, :dfn, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an dt, another
    # to retrieve an  dt, and another to check the dt's existence.
    #
    # @example
    #   dt(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an dt.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when dt method is called
    #
    def dt(name, identifier={:index => 0}, &block)
      element(name, :dt, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an em, another
    # to retrieve an  em, and another to check the em's existence.
    #
    # @example
    #   em(:title, :id => 'title')
    #   # will generate 'title', 'title_element', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an em.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when em method is called
    #
    def em(name, identifier={:index => 0}, &block)
      element(name, :em, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an figcaption, another
    # to retrieve an  figcaption, and another to check the figcaption's existence.
    #
    # @example
    #   figcaption(:title, :id => 'title')
    #   # will generate 'title', 'title_elfigcaptionent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an figcaption.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when figcaption method is called
    #
    def figcaption(name, identifier={:index => 0}, &block)
      element(name, :figcaption, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an figure, another
    # to retrieve an  figure, and another to check the figure's existence.
    #
    # @example
    #   figure(:title, :id => 'title')
    #   # will generate 'title', 'title_elfigureent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an figure.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when figure method is called
    #
    def figure(name, identifier={:index => 0}, &block)
      element(name, :figure, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an footer, another
    # to retrieve an  footer, and another to check the footer's existence.
    #
    # @example
    #   footer(:title, :id => 'title')
    #   # will generate 'title', 'title_elfooterent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an footer.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when footer method is called
    #
    def footer(name, identifier={:index => 0}, &block)
      element(name, :footer, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an header, another
    # to retrieve an  header, and another to check the header's existence.
    #
    # @example
    #   header(:title, :id => 'title')
    #   # will generate 'title', 'title_elheaderent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an header.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when header method is called
    #
    def header(name, identifier={:index => 0}, &block)
      element(name, :header, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an hgroup, another
    # to retrieve an  hgroup, and another to check the hgroup's existence.
    #
    # @example
    #   hgroup(:title, :id => 'title')
    #   # will generate 'title', 'title_elhgroupent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an hgroup.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when hgroup method is called
    #
    def hgroup(name, identifier={:index => 0}, &block)
      element(name, :hgroup, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an kbd, another
    # to retrieve an  kbd, and another to check the kbd's existence.
    #
    # @example
    #   kbd(:title, :id => 'title')
    #   # will generate 'title', 'title_elkbdent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an kbd.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when kbd method is called
    #
    def kbd(name, identifier={:index => 0}, &block)
      element(name, :kbd, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an mark, another
    # to retrieve an  mark, and another to check the mark's existence.
    #
    # @example
    #   mark(:title, :id => 'title')
    #   # will generate 'title', 'title_elmarkent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an mark.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when mark method is called
    #
    def mark(name, identifier={:index => 0}, &block)
      element(name, :mark, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an nav, another
    # to retrieve an  nav, and another to check the nav's existence.
    #
    # @example
    #   nav(:title, :id => 'title')
    #   # will generate 'title', 'title_elnavent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an nav.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when nav method is called
    #
    def nav(name, identifier={:index => 0}, &block)
      element(name, :nav, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an noscript, another
    # to retrieve an  noscript, and another to check the noscript's existence.
    #
    # @example
    #   noscript(:title, :id => 'title')
    #   # will generate 'title', 'title_elnoscriptent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an noscript.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when noscript method is called
    #
    def noscript(name, identifier={:index => 0}, &block)
      element(name, :noscript, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an rp, another
    # to retrieve an  rp, and another to check the rp's existence.
    #
    # @example
    #   rp(:title, :id => 'title')
    #   # will generate 'title', 'title_elrpent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an rp.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when rp method is called
    #
    def rp(name, identifier={:index => 0}, &block)
      element(name, :rp, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an rt, another
    # to retrieve an  rt, and another to check the rt's existence.
    #
    # @example
    #   rt(:title, :id => 'title')
    #   # will generate 'title', 'title_elrtent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an rt.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when rt method is called
    #
    def rt(name, identifier={:index => 0}, &block)
      element(name, :rt, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an ruby, another
    # to retrieve an  ruby, and another to check the ruby's existence.
    #
    # @example
    #   ruby(:title, :id => 'title')
    #   # will generate 'title', 'title_elrubyent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an ruby.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when ruby method is called
    #
    def ruby(name, identifier={:index => 0}, &block)
      element(name, :ruby, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an samp, another
    # to retrieve an  samp, and another to check the samp's existence.
    #
    # @example
    #   samp(:title, :id => 'title')
    #   # will generate 'title', 'title_elsampent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an samp.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when samp method is called
    #
    def samp(name, identifier={:index => 0}, &block)
      element(name, :samp, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an section, another
    # to retrieve an  section, and another to check the section's existence.
    #
    # @example
    #   section(:title, :id => 'title')
    #   # will generate 'title', 'title_elsectionent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an section.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when section method is called
    #
    def section(name, identifier={:index => 0}, &block)
      element(name, :section, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an sub, another
    # to retrieve an  sub, and another to check the sub's existence.
    #
    # @example
    #   sub(:title, :id => 'title')
    #   # will generate 'title', 'title_elsubent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an sub.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when sub method is called
    #
    def sub(name, identifier={:index => 0}, &block)
      element(name, :sub, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an summary, another
    # to retrieve an  summary, and another to check the summary's existence.
    #
    # @example
    #   summary(:title, :id => 'title')
    #   # will generate 'title', 'title_elsummaryent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an summary.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when summary method is called
    #
    def summary(name, identifier={:index => 0}, &block)
      element(name, :summary, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an sup, another
    # to retrieve an  sup, and another to check the sup's existence.
    #
    # @example
    #   sup(:title, :id => 'title')
    #   # will generate 'title', 'title_elsupent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an sup.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when sup method is called
    #
    def sup(name, identifier={:index => 0}, &block)
      element(name, :sup, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an var, another
    # to retrieve an  var, and another to check the var's existence.
    #
    # @example
    #   var(:title, :id => 'title')
    #   # will generate 'title', 'title_elvarent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an var.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when var method is called
    #
    def var(name, identifier={:index => 0}, &block)
      element(name, :var, identifier, &block)
    end

    #
    # adds three methods - one to retrieve the text of an wbr, another
    # to retrieve an  wbr, and another to check the wbr's existence.
    #
    # @example
    #   wbr(:title, :id => 'title')
    #   # will generate 'title', 'title_elwbrent', and 'title?' methods
    #
    # @param [Symbol] the name used for the generated methods
    # @param [Hash] identifier how we find an wbr.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when wbr method is called
    #
    def wbr(name, identifier={:index => 0}, &block)
      element(name, :wbr, identifier, &block)
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
  end
end
