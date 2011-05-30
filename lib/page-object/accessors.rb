
#
# Contains the class level methods that are inserted into your page objects
# when you include the PageObject module.  These methods will generate another
# set of methods that provide access to the elements on the web pages.
#
module PageObject
  module Accessors
    #
    # adds three methods to the page object - one to set text in a text field,
    # another to retrieve text from a text field and another to return the text
    # field element.
    #
    # Example:  text_field(:first_name, {:id => "first_name"})
    # will generate the 'first_name', 'first_name=' and 'first_name_text_field methods.
    #
    # @param  the name used for the generated methods
    # @param identifier how we find a text_field.  The valid values are:
    #   :class => Watir and Selenium
    #   :css => Watir and Selenium
    #   :id => Watir and Selenium
    #   :index => Watir only
    #   :name => Watir and Selenium
    #   :tag_name => Watir and Selenium
    #   :text => Watir only
    #   :value => Watir only
    #   :xpath => Watir and Selenium
    #
    def text_field(name, identifier)
      define_method(name) do
        platform.text_field_value_for identifier
      end
      define_method("#{name}=") do |value|
        platform.text_field_value_set(identifier, value)
      end
      define_method("#{name}_text_field") do
        platform.text_field_for identifier
      end
    end

    #
    # adds three methods - one to select an item in a drop-down,
    # another to fetch the currently selected item and another
    # to retrieve the select list element.
    #
    # Example:  select_list(:state, {:id => "state"})
    # will generate the 'state', 'state=' and 'state_select_list' methods
    #
    # @param the name used for the generated methods
    # @param identifier how we find a select_list.  The valid values are:
    #   :class => Watir and Selenium
    #   :id => Watir and Selenium
    #   :index => Watir only
    #   :name => Watir and Selenium
    #   :text => Watir only
    #   :value => Watir only
    #   :xpath => Watir and Selenium
    #
    def select_list(name, identifier)
      define_method(name) do
        platform.select_list_value_for identifier
      end
      define_method("#{name}=") do |value|
        platform.select_list_value_set(identifier, value)
      end
      define_method("#{name}_select_list") do
        platform.select_list_for identifier
      end
    end

    #
    # adds two methods - one to select a link and another
    # to return a PageObject::Elements::Link object representing
    # the link.
    #
    # Example:  link(:add_to_cart, {:text => "Add to Cart"})
    # will generate the 'add_to_cart' and 'add_to_cart_link'
    # method.
    #
    # @param the name used for the generated methods
    # @param identifier how we find a link.  The valid values are:
    #   :class => Watir and Selenium
    #   :href => Watir only
    #   :id => Watir and Selenium
    #   :index => Watir only
    #   :link => Watir and Selenium
    #   :link_text => Watir and Selenium
    #   :name => Watir and Selenium
    #   :text => Watir and Selenium
    #   :xpath => Watir and Selenium
    #
    def link(name, identifier)
      define_method(name) do
        platform.click_link_for identifier
      end
      define_method("#{name}_link") do
        platform.link_for identifier
      end
    end
    
    #
    # adds four methods - one to check, another to uncheck, another
    # to return the state of a checkbox, and a final method to return
    # a PageObject::Elements::CheckBox object representing the checkbox.
    #
    # Example: checkbox(:active, {:name => "is_active"})
    # will generate the 'check_active', 'uncheck_active',
    # 'active_checked?' and 'active_checkbox' methods.
    #
    # @param the name used for the generated methods
    # @param identifier how we find a checkbox.  The valid values are:
    #   :class => Watir and Selenium
    #   :id => Watir and Selenium
    #   :index => Watir only
    #   :name => Watir and Selenium
    #   :xpath => Watir and Selenium
    #
    def checkbox(name, identifier)
      define_method("check_#{name}") do
        platform.check_checkbox(identifier)
      end
      define_method("uncheck_#{name}") do
        platform.uncheck_checkbox(identifier)
      end
      define_method("#{name}_checked?") do
        platform.checkbox_checked?(identifier)
      end
      define_method("#{name}_checkbox") do
        platform.checkbox_for identifier
      end
    end
    
    #
    # adds four methods - one to select, another to clear,
    # another to return if a radio button is selected, and
    # another method to return a PageObject::Elements::RadioButton
    # object representing the radio button element
    #
    # Example:  radio_button(:north, {:id => "north"})
    # will generate 'select_north', 'clear_north',
    # 'north_selected?' and 'north_radio_button' methods
    #
    # @param the name used for the generated methods
    # @param identifier how we find a checkbox.  The valid values are:
    #   :class => Watir and Selenium
    #   :id => Watir and Selenium
    #   :index => Watir only
    #   :name => Watir and Selenium
    #   :xpath => Watir and Selenium
    #
    def radio_button(name, identifier)
      define_method("select_#{name}") do
        platform.select_radio(identifier)
      end
      define_method("clear_#{name}") do
        platform.clear_radio(identifier)
      end
      define_method("#{name}_selected?")  do
        platform.radio_selected?(identifier)
      end
      define_method("#{name}_radio_button") do
        platform.radio_button_for identifier
      end
    end

    #
    # adds two methods - one to click a button and another to
    # return the button element.
    #
    # Example: button(:purchase, :id => 'purchase')
    # will generate a 'purchase' and 'purchase_button' methods.
    #
    # @param the name used for the generated methods
    # @param identifier how we find a checkbox.  The valid values are:
    #   :class => Watir and Selenium
    #   :id => Watir and Selenium
    #   :index => Watir only
    #   :name => Watir and Selenium
    #   :text => Watir only
    #   :xpath => Watir and Selenium
    #
    def button(name, identifier)
      define_method(name) do
        platform.click_button_for identifier
      end
      define_method("#{name}_button") do
        platform.button_for identifier
      end
    end
    
    #
    # adds two methods - one to retrieve the text from a div
    # and another to return the div element
    #
    # Example:  div(:message, {:id => 'message'})
    # will generate a 'message' and 'message_div' methods
    #
    # @param the name used for the generated methods
    # @param identifier how we find a checkbox.  The valid values are:
    #   :class => Watir and Selenium
    #   :id => Watir and Selenium
    #   :index => Watir only
    #   :name => Selenium only
    #   :xpath => Watir and Selenium
    #
    def div(name, identifier) 
      define_method("#{name}") do
        platform.div_text_for identifier
      end
      define_method("#{name}_div") do
        platform.div_for identifier
      end
    end

    #
    # adds a method to retrieve the table element
    #
    # Example: table(:cart, :id => 'shopping_cart')
    # will generate a 'cart_table' method.
    #
    # @param the name used for the generated methods
    # @param identifier how we find a checkbox.  The valid values are:
    #   :class => Watir and Selenium
    #   :id => Watir and Selenium
    #   :index => Watir only
    #   :name => Selenium only
    #   :xpath => Watir and Selenium
    #
    def table(name, identifier)
      define_method("#{name}_table") do
        platform.table_for identifier
      end
    end
    
    #
    # adds two methods  one to retrieve the text from a table cell
    # and another to return the table cell element
    #
    # Example: cell(:total, :id => 'total_cell')
    # will generate a 'total' and 'total_cell' methods
    #
    # @param the name used for the generated methods
    # @param identifier how we find a checkbox.  The valid values are:
    #   :class => Watir and Selenium
    #   :id => Watir and Selenium
    #   :index => Watir only
    #   :name => Selenium only
    #   :xpath => Watir and Selenium
    #
    def cell(name, identifier)
      define_method("#{name}") do
        platform.cell_text_for identifier
      end
      define_method("#{name}_cell") do
        platform.cell_for identifier
      end
    end
  end
end
