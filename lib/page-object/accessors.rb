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
    
    # adds a methods to select a link.
    #
    # Example:  link(:add_to_cart, {:text => "Add to Cart"})
    # will generate the 'add_to_cart' method that will click the link.
    #
    # @param identifier is a has.  The valid keys are
    # [:id, :class, :name, :xpath, :link, :link_text, :text]
    def link(name, identifier)
      define_method(name) do
        driver.click_link_for identifier
      end
    end
    
  end
end
