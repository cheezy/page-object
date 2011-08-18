module PageObject
  module  ElementLocators
    
    #
    # Finds a button
    #
    # @param [Hash] identifier how we find a button.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :text => Watir only
    #   * :value => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def button(identifier)
      platform.button_for(identifier.clone)
    end
    
    #
    # Finds a text field
    #
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
    #
    def text_field(identifier)
      platform.text_field_for(identifier.clone)
    end
    
  end
end