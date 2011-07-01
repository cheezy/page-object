
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
    # adds three methods to the page object - one to set text in a text field,
    # another to retrieve text from a text field and another to return the text
    # field element.
    #
    # @example  
    #   text_field(:first_name, :id => "first_name") 
    #   # will generate 'first_name', 'first_name=' and 'first_name_text_field' methods
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
        platform.text_field_value_for identifier.clone
      end
      define_method("#{name}=") do |value|
        platform.text_field_value_set(identifier.clone, value)
      end
      define_method("#{name}_text_field") do
        block ? block.call(browser) : platform.text_field_for(identifier.clone)
      end
    end
    
    #
    # adds two methods to the page object - one to get the text from a hidden field
    # and another to retrieve the hidden field element.
    #
    # @example
    #   hidden_field(:user_id, :id => "user_identity")
    #   # will generate 'user_id' and 'user_id_hidden_field' methods
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
    #   * :text => Watir only
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def hidden_field(name, identifier=nil, &block)
      define_method(name) do
        platform.hidden_field_value_for identifier.clone
      end
      define_method("#{name}_hidden_field") do
        block ? block.call(browser) : platform.hidden_field_for(identifier.clone)
      end
    end
    
    #
    # adds three methods to the page object - one to set text in a text area,
    # another to retrieve text from a text area and another to return the text
    # area element.
    #
    # @example
    #   text_area(:address, :id => "address")
    #   # will generate 'address', 'address=' and 'address_text_area methods
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
        platform.text_area_value_for identifier.clone
      end
      define_method("#{name}=") do |value|
        platform.text_area_value_set(identifier.clone, value)
      end
      define_method("#{name}_text_area") do
        block ? block.call(browser) : platform.text_area_for(identifier.clone)
      end
    end

    #
    # adds three methods - one to select an item in a drop-down,
    # another to fetch the currently selected item and another
    # to retrieve the select list element.
    #
    # @example
    #   select_list(:state, :id => "state")
    #   # will generate 'state', 'state=' and 'state_select_list' methods
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
        platform.select_list_value_for identifier.clone
      end
      define_method("#{name}=") do |value|
        platform.select_list_value_set(identifier.clone, value)
      end
      define_method("#{name}_select_list") do
        block ? block.call(browser) : platform.select_list_for(identifier.clone)
      end
    end

    #
    # adds two methods - one to select a link and another
    # to return a PageObject::Elements::Link object representing
    # the link.
    #
    # @example
    #   link(:add_to_cart, :text => "Add to Cart")
    #   # will generate 'add_to_cart' and 'add_to_cart_link' methods
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a link.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :href => Watir only
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
        platform.click_link_for identifier.clone
      end
      define_method("#{name}_link") do
        block ? block.call(browser) : platform.link_for(identifier.clone)
      end
    end
    
    #
    # adds four methods - one to check, another to uncheck, another
    # to return the state of a checkbox, and a final method to return
    # a PageObject::Elements::CheckBox object representing the checkbox.
    #
    # @example
    #   checkbox(:active, :name => "is_active")
    #   # will generate 'check_active', 'uncheck_active', 'active_checked?' and 'active_checkbox' methods
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
        platform.check_checkbox(identifier.clone)
      end
      define_method("uncheck_#{name}") do
        platform.uncheck_checkbox(identifier.clone)
      end
      define_method("#{name}_checked?") do
        platform.checkbox_checked?(identifier.clone)
      end
      define_method("#{name}_checkbox") do
        block ? block.call(browser) : platform.checkbox_for(identifier.clone)
      end
    end
    
    #
    # adds four methods - one to select, another to clear,
    # another to return if a radio button is selected, and
    # another method to return a PageObject::Elements::RadioButton
    # object representing the radio button element
    #
    # @example
    #   radio_button(:north, :id => "north")
    #   # will generate 'select_north', 'clear_north', 'north_selected?' and 'north_radio_button' methods
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
        platform.select_radio(identifier.clone)
      end
      define_method("clear_#{name}") do
        platform.clear_radio(identifier.clone)
      end
      define_method("#{name}_selected?")  do
        platform.radio_selected?(identifier.clone)
      end
      define_method("#{name}_radio_button") do
        block ? block.call(browser) : platform.radio_button_for(identifier.clone)
      end
    end

    #
    # adds two methods - one to click a button and another to
    # return the button element.
    #
    # @example
    #   button(:purchase, :id => 'purchase')
    #   # will generate 'purchase' and 'purchase_button' methods
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a button.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir only
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def button(name, identifier=nil, &block)
      define_method(name) do
        platform.click_button_for identifier.clone
      end
      define_method("#{name}_button") do
        block ? block.call(browser) : platform.button_for(identifier.clone)
      end
    end
    
    #
    # adds two methods - one to retrieve the text from a div
    # and another to return the div element
    #
    # @example
    #   div(:message, :id => 'message')
    #   # will generate 'message' and 'message_div' methods
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a div.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Selenium always and Watir only when used with other values.
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def div(name, identifier=nil, &block)
      define_method(name) do
        platform.div_text_for identifier.clone
      end
      define_method("#{name}_div") do
        block ? block.call(browser) : platform.div_for(identifier.clone)
      end
    end

    #
    # adds two methods - one to retrieve the text from a span
    # and another to return the span element
    #
    # @example
    #   span(:alert, :id => 'alert')
    #   # will generate 'alert' and 'alert_span' methods
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a span.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Selenium always and Watir only when used with other values.
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def span(name, identifier=nil, &block)
      define_method(name) do
        platform.span_text_for identifier.clone
      end
      define_method("#{name}_span") do
        block ? block.call(browser) : platform.span_for(identifier.clone)
      end
    end

    #
    # adds a method to retrieve the table element
    #
    # @example
    #   table(:cart, :id => 'shopping_cart')
    #   # will generate a 'cart_table' method
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a table.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Selenium always and Watir only when used with other values.
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def table(name, identifier=nil, &block)
      define_method("#{name}_table") do
        block ? block.call(browser) : platform.table_for(identifier.clone)
      end
    end
    
    #
    # adds two methods  one to retrieve the text from a table cell
    # and another to return the table cell element
    #
    # @example
    #   cell(:total, :id => 'total_cell')
    #   # will generate 'total' and 'total_cell' methods
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a cell.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir only
    #   * :name => Selenium always and Watir only when used with other values.
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def cell(name, identifier=nil, &block)
      define_method("#{name}") do
        platform.cell_text_for identifier.clone
      end
      define_method("#{name}_cell") do
        block ? block.call(browser) : platform.cell_for(identifier.clone)
      end
    end
    
    #
    # adds a method to retrieve the image element
    #
    # @example
    #   image(:logo, :id => 'logo')
    #   # will generate a 'logo_image' method
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
      define_method("#{name}_image") do
        block ? block.call(browser) : platform.image_for(identifier.clone)
      end
    end
    
    #
    # adds a method to retrieve the form element
    #
    # @example
    #   form(:login, :id => 'login')
    #   # will generate a 'login_form' method
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
      define_method("#{name}_form") do
        block ? block.call(browser) : platform.form_for(identifier.clone)
      end
    end
    
    #
    # adds two methods - one to retrieve the text from a list item
    # and another to return the list item element
    #
    # @example
    #   list_item(:item_one, :id => 'one')
    #   # will generate 'item_one' and 'item_one_list_item' methods
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find a list item.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir only
    #   * :name => Selenium only
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def list_item(name, identifier=nil, &block)
      define_method(name) do
        platform.list_item_text_for identifier
      end
      define_method("#{name}_list_item") do
        block ? block.call(browser) : platform.list_item_for(identifier)
      end
    end
    
    #
    # adds a method to retrieve the unordered list element
    #
    # @example
    #   unordered_list(:menu, :id => 'main_menu')
    #   # will generate a 'menu_unordered_list' method
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find an unordered list.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir only
    #   * :name => Selenium only
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def unordered_list(name, identifier=nil, &block)
      define_method("#{name}_unordered_list") do
        block ? block.call(browser) : platform.unordered_list_for(identifier)
      end
    end
    
    #
    # adds a method to retrieve the ordered list element
    #
    # @example
    #   ordered_list(:top_five, :id => 'top')
    #   # will generate a 'top_five_ordered_list' method
    #
    # @param [String] the name used for the generated methods
    # @param [Hash] identifier how we find an unordered list.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir only
    #   * :name => Selenium only
    #   * :xpath => Watir and Selenium
    # @param optional block to be invoked when element method is called
    #
    def ordered_list(name, identifier=nil, &block)
      define_method("#{name}_ordered_list") do
        block ? block.call(browser) : platform.ordered_list_for(identifier)
      end
    end
  end
end
