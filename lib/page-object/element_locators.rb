module PageObject
  module  ElementLocators

    def self.included(cls)
      ::PageObject::LocatorGenerator.generate_locators(cls)
    end

    private

    def locator(identifier)
      identifier[0] ? identifier[0] : {:index => 0}
    end

    #
    # Finds an element
    #
    # @param [Symbol] the name of the tag for the element
    # @param [Hash] identifier how we find an element.  You can use a multiple paramaters
    #   by combining of any of the following except xpath.  The valid keys are:
    #   * :class => Watir and Selenium
    #   * :id => Watir and Selenium
    #   * :index => Watir and Selenium
    #   * :name => Watir and Selenium
    #   * :xpath => Watir and Selenium
    #
    def element(tag, identifier={:index => 0})
      platform.element_for(tag, identifier.clone)
    end
  end
end
