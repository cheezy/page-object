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
    #
    def page_url(url)
      define_method("goto") do
        platform.navigate_to url
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
    # adds three methods to the page object - one to set text in a text field,
    # another to retrieve text from a text field and another to return the text
    # field element.
    #
    # @example  
    #   text_field(:first_name, :id => "first_name") 
    #   # will generate 'first_name', 'first_name=' and 'first_name_element' methods
    #
    # @param  [String] the name used for the generated methods
    # @param [Hash] identifier how we find a text field.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :css => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :tag_name => Watir and Selenium
    #   * :text => Watir only
    #   * :value => Watir only
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def text_field(name, identifier=nil, &block)
      define_method(name) do
        return platform.text_field_value_for identifier.clone unless block
        self.send("#{name}_element").value
      end
      define_method("#{name}=") do |value|
        return platform.text_field_value_set(identifier.clone, value) unless block
        self.send("#{name}_element").value = value
      end
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.text_field_for(identifier.clone)
      end
      alias_method "#{name}_text_field".to_sym, "#{name}_element".to_sym
    end
    
    #
    # adds two methods to the page object - one to get the text from a hidden field
    # and another to retrieve the hidden field element.
    #
    # @example
    #   hidden_field(:user_id, :id => "user_identity")
    #   # will generate 'user_id' and 'user_id_element' methods
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a hidden field.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :css => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :tag_name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def hidden_field(name, identifier=nil, &block)
      define_method(name) do
        return platform.hidden_field_value_for identifier.clone unless block
        self.send("#{name}_element").value
      end
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.hidden_field_for(identifier.clone)
      end
      alias_method "#{name}_hidden_field".to_sym, "#{name}_element".to_sym
    end

    #
    # adds three methods to the page object - one to set text in a text area,
    # another to retrieve text from a text area and another to return the text
    # area element.
    #
    # @example
    #   text_area(:address, :id => "address")
    #   # will generate 'address', 'address=' and 'address_element methods
    #
    # @param  [String] the name used for the generated methods
    # @param [Hash] identifier how we find a text area.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :css => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :tag_name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def text_area(name, identifier=nil, &block)
      define_method(name) do
        return platform.text_area_value_for identifier.clone unless block
        self.send("#{name}_element").value
      end
      define_method("#{name}=") do |value|
        return platform.text_area_value_set(identifier.clone, value) unless block
        self.send("#{name}_element").value = value
      end
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.text_area_for(identifier.clone)
      end
      alias_method "#{name}_text_area".to_sym, "#{name}_element".to_sym
    end

    #
    # adds three methods - one to select an item in a drop-down,
    # another to fetch the currently selected item and another
    # to retrieve the select list element.
    #
    # @example
    #   select_list(:state, :id => "state")
    #   # will generate 'state', 'state=' and 'state_element' methods
    #
    # @param [String] the name used for the generated methods
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
    def select_list(name, identifier=nil, &block)
      define_method(name) do
        return platform.select_list_value_for identifier.clone unless block
        self.send("#{name}_element").value
      end
      define_method("#{name}=") do |value|
        return platform.select_list_value_set(identifier.clone, value) unless block
        self.send("#{name}_element").select(value)
      end
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.select_list_for(identifier.clone)
      end
      alias_method "#{name}_select_list".to_sym, "#{name}_element".to_sym
    end

    #
    # adds two methods - one to select a link and another
    # to return a PageObject::Elements::Link object representing
    # the link.
    #
    # @example
    #   link(:add_to_cart, :text => "Add to Cart")
    #   # will generate 'add_to_cart' and 'add_to_cart_element' methods
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a link.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :href => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :link => Watir and Selenium
    #   * :link_text => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def link(name, identifier=nil, &block)
      define_method(name) do
        return platform.click_link_for identifier.clone unless block
        self.send("#{name}_element").click
      end
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.link_for(identifier.clone)
      end
      alias_method "#{name}_link".to_sym, "#{name}_element".to_sym
    end

    #
    # adds four methods - one to check, another to uncheck, another
    # to return the state of a checkbox, and a final method to return
    # a PageObject::Elements::CheckBox object representing the checkbox.
    #
    # @example
    #   checkbox(:active, :name => "is_active")
    #   # will generate 'check_active', 'uncheck_active', 'active_checked?' and 'active_element' methods
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a checkbox.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def checkbox(name, identifier=nil, &block)
      define_method("check_#{name}") do
        return platform.check_checkbox(identifier.clone) unless block
        self.send("#{name}_element").check
      end
      define_method("uncheck_#{name}") do
        return platform.uncheck_checkbox(identifier.clone) unless block
        self.send("#{name}_element").uncheck
      end
      define_method("#{name}_checked?") do
        return platform.checkbox_checked?(identifier.clone) unless block
        self.send("#{name}_element").checked?
      end
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.checkbox_for(identifier.clone)
      end
      alias_method "#{name}_checkbox".to_sym, "#{name}_element".to_sym
    end

    #
    # adds four methods - one to select, another to clear,
    # another to return if a radio button is selected, and
    # another method to return a PageObject::Elements::RadioButton
    # object representing the radio button element
    #
    # @example
    #   radio_button(:north, :id => "north")
    #   # will generate 'select_north', 'clear_north', 'north_selected?' and 'north_element' methods
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a radio button.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def radio_button(name, identifier=nil, &block)
      define_method("select_#{name}") do
        return platform.select_radio(identifier.clone) unless block
        self.send("#{name}_element").select
      end
      define_method("clear_#{name}") do
        return platform.clear_radio(identifier.clone) unless block
        self.send("#{name}_element").clear
      end
      define_method("#{name}_selected?") do
        return platform.radio_selected?(identifier.clone) unless block
        self.send("#{name}_element").selected?
      end
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.radio_button_for(identifier.clone)
      end
      alias_method "#{name}_radio_button".to_sym, "#{name}_element".to_sym
    end

    #
    # adds two methods - one to click a button and another to
    # return the button element.
    #
    # @example
    #   button(:purchase, :id => 'purchase')
    #   # will generate 'purchase' and 'purchase_element' methods
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a button.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir only
    #   * :value => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def button(name, identifier=nil, &block)
      define_method(name) do
        platform.click_button_for identifier.clone
      end
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.button_for(identifier.clone)
      end
      alias_method "#{name}_button".to_sym, "#{name}_element".to_sym
    end

    #
    # adds two methods - one to retrieve the text from a div
    # and another to return the div element
    #
    # @example
    #   div(:message, :id => 'message')
    #   # will generate 'message' and 'message_element' methods
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a div.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def div(name, identifier=nil, &block)
      define_method(name) do
        platform.div_text_for identifier.clone
      end
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.div_for(identifier.clone)
      end
      alias_method "#{name}_div".to_sym, "#{name}_element".to_sym
    end

    #
    # adds two methods - one to retrieve the text from a span
    # and another to return the span element
    #
    # @example
    #   span(:alert, :id => 'alert')
    #   # will generate 'alert' and 'alert_element' methods
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a span.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def span(name, identifier=nil, &block)
      define_method(name) do
        platform.span_text_for identifier.clone
      end
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.span_for(identifier.clone)
      end
      alias_method "#{name}_span".to_sym, "#{name}_element".to_sym
    end

    #
    # adds a method to retrieve the table element
    #
    # @example
    #   table(:cart, :id => 'shopping_cart')
    #   # will generate a 'cart_element' method
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a table.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def table(name, identifier=nil, &block)
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.table_for(identifier.clone)
      end
      alias_method "#{name}_table".to_sym, "#{name}_element".to_sym
    end

    #
    # adds two methods  one to retrieve the text from a table cell
    # and another to return the table cell element
    #
    # @example
    #   cell(:total, :id => 'total_cell')
    #   # will generate 'total' and 'total_element' methods
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a cell.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir only
    #   * :name => Watir and Selenium
    #   * :text => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def cell(name, identifier=nil, &block)
      define_method("#{name}") do
        platform.cell_text_for identifier.clone
      end
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.cell_for(identifier.clone)
      end
      alias_method "#{name}_cell".to_sym, "#{name}_element".to_sym
    end

    #
    # adds a method to retrieve the image element
    #
    # @example
    #   image(:logo, :id => 'logo')
    #   # will generate a 'logo_element' method
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find an image.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def image(name, identifier=nil, &block)
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.image_for(identifier.clone)
      end
      alias_method "#{name}_image".to_sym, "#{name}_element".to_sym
    end

    #
    # adds a method to retrieve the form element
    #
    # @example
    #   form(:login, :id => 'login')
    #   # will generate a 'login_element' method
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a form.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def form(name, identifier=nil, &block)
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.form_for(identifier.clone)
      end
      alias_method "#{name}_form".to_sym, "#{name}_element".to_sym
    end

    #
    # adds two methods - one to retrieve the text from a list item
    # and another to return the list item element
    #
    # @example
    #   list_item(:item_one, :id => 'one')
    #   # will generate 'item_one' and 'item_one_element' methods
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a list item.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def list_item(name, identifier=nil, &block)
      define_method(name) do
        platform.list_item_text_for identifier.clone
      end
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.list_item_for(identifier.clone)
      end
      alias_method "#{name}_list_item".to_sym, "#{name}_element".to_sym
    end

    #
    # adds a method to retrieve the unordered list element
    #
    # @example
    #   unordered_list(:menu, :id => 'main_menu')
    #   # will generate a 'menu_element' method
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find an unordered list.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def unordered_list(name, identifier=nil, &block)
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.unordered_list_for(identifier.clone)
      end
      alias_method "#{name}_unordered_list".to_sym, "#{name}_element".to_sym
    end

    #
    # adds a method to retrieve the ordered list element
    #
    # @example
    #   ordered_list(:top_five, :id => 'top')
    #   # will generate a 'top_five_element' method
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find an ordered list.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def ordered_list(name, identifier=nil, &block)
      define_method("#{name}_element") do
        return call_block(&block) if block
        platform.ordered_list_for(identifier.clone)
      end
      alias_method "#{name}_ordered_list".to_sym, "#{name}_element".to_sym
    end
  end
end
