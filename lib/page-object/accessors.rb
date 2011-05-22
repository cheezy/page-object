
#
# Contains the class level methods that are inserted into your page objects
# when you include the PageObject module.  These methods will generate another
# set of methods that provide access to the elements on the web pages.
#
module PageObject
  module Accessors
    #
    # adds two methods to the page object - one to set text in a text field
    # and another to retrieve text from a text field.
    #
    # Example:  text_field(:first_name, {:id => "first_name"})
    # will generate the 'first_name' and 'first_name=' methods.
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
        driver.text_field_value_for identifier
      end
      define_method("#{name}=") do |value|
        driver.text_field_value_set(identifier, value)
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
        driver.select_list_value_for identifier
      end
      define_method("#{name}=") do |value|
        driver.select_list_value_set(identifier, value)
      end
      define_method("#{name}_select_list") do
        driver.select_list_for identifier
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
        driver.click_link_for identifier
      end
      define_method("#{name}_link") do
        driver.link_for identifier
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
        driver.check_checkbox(identifier)
      end
      define_method("uncheck_#{name}") do
        driver.uncheck_checkbox(identifier)
      end
      define_method("#{name}_checked?") do
        driver.checkbox_checked?(identifier)
      end
      define_method("#{name}_checkbox") do
        driver.checkbox_for identifier
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
        driver.select_radio(identifier)
      end
      define_method("clear_#{name}") do
        driver.clear_radio(identifier)
      end
      define_method("#{name}_selected?")  do
        driver.radio_selected?(identifier)
      end
      define_method("#{name}_radio_button") do
        driver.radio_button_for identifier
      end
    end

    def button(name, identifier)
      define_method(name) do
      end
    end
  end
end
