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
  end
end
