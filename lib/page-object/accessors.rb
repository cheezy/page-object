module PageObject
  module Accessors
    # adds two methods to the page object - one to set text in a text field
    # and another to retrieve text from a text field.
    #
    # Example:  text_field(:first_name, {:id => "first_name"})
    # will generate the 'first_name' and 'first_name=' methods.
    #
    # @param  the name used for the generated methods
    # @param identifies how we find a text_field.  The valid values are:
    #   :class => Watir and Selenium
    #   :css => Watir and Selenium
    #   :id => Watir and Selenium
    #   :index => Watir only
    #   :name => Watir and Selenium
    #   :tag_name => Watir and Selenium
    #   :text => Watir only
    #   :value => Watir only
    #   :xpath => Watir and Selenium
    def text_field(name, identifier)
      define_method(name) do
        driver.text_field_value_for identifier
      end
      define_method("#{name}=") do |value|
        driver.text_field_value_set(identifier, value)
      end
    end
    
    # adds two methods - one to select an item in a drop-down and
    # another to fetch the currently selected item.
    #
    # Example:  select_list(:state, {:id => "state"})
    # will generate the 'state' and 'state=' methods
    #
    # @param the name used for the generated methods
    # @param identifies how we find a select_list.  The valid values are:
    #   :class => Watir and Selenium
    #   :id => Watir and Selenium
    #   :index => Watir only
    #   :name => Watir and Selenium
    #   :text => Watir only
    #   :value => Watir only
    #   :xpath => Watir and Selenium
    def select_list(name, identifier)
      define_method(name) do
        driver.select_list_value_for identifier
      end
      define_method("#{name}=") do |value|
        driver.select_list_value_set(identifier, value)
      end
    end
    
    # adds a methods to select a link.
    #
    # Example:  link(:add_to_cart, {:text => "Add to Cart"})
    # will generate the 'add_to_cart' method that will click the link.
    #
    # @param the name used for the generated methods
    # @param identifies how we find a link.  The valid values are:
    #   :class => Watir and Selenium
    #   :href => Watir only
    #   :id => Watir and Selenium
    #   :index => Watir only
    #   :link => Watir and Selenium
    #   :link_text => Watir and Selenium
    #   :name => Watir and Selenium
    #   :text => Watir and Selenium
    #   :xpath => Watir and Selenium
    def link(name, identifier)
      define_method(name) do
        driver.click_link_for identifier
      end
    end

    # adds three methods - one to check, another to uncheck and a
    # third to return the state of a checkbox
    #
    # Example: checkbox(:active, {:name => "is_active"})
    # will generate the 'check_active', 'uncheck_active' and
    # 'active_checked?' methods.
    #
    # @param the name used for the generated methods
    # @param identifies how we find a checkbox.  The valid values are:
    #   :class => Watir and Selenium
    #   :id => Watir and Selenium
    #   :index => Watir only
    #   :name => Watir and Selenium
    #   :xpath => Watir and Selenium
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
    end
  end
end
