module PageObject
  module Accessors
    # adds two methods to the page object - one to set text in a text field
    # and another to retrieve text from a text field.
    #
    # Example:  text_field(:first_name, {:id => "first_name"})
    # will generate the 'first_name' and 'first_name=' methods.
    def text_field(name, identifier)
      define_method(name) do
        driver.text_field_value_for identifier
      end
      define_method("#{name}=") do |value|
        driver.text_field_value_set(identifier, value)
      end
    end
    
    # adds two methods - one to select a link and another
    # to select a link and not wait for the corresponding
    # action to complete.
    #
    # Example:  link(:add_to_cart, {:text => "Add to Cart"})
    # will generate the 'add_to_cart' and 'add_to_cart_no_wait'
    # methods
    def link(name, identifier)
      define_method(name) do
        driver.click_link_for identifier
      end
      define_method("#{name}_no_wait") do
        driver.click_link_no_wait_for identifier
      end
    end
    
  end
end
