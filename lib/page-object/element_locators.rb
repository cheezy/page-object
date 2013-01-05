require 'page-object/locator_generator'

module PageObject
  module  ElementLocators

    def self.included(cls)
      ::PageObject::LocatorGenerator.generate_locators(cls)
    end

    def element(tag, identifier={:index => 0})
      platform.element_for(tag, identifier.clone)
    end

    private

    def locator(identifier)
      identifier[0] ? identifier[0] : {:index => 0}
    end

  end
end
