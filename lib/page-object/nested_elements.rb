require 'page-object/locator_generator'

module PageObject
  module NestedElements

    def self.included(cls)
      ::PageObject::LocatorGenerator.generate_locators(cls)
    end

    private

    def locator(identifier)
      identifier[0] ? identifier[0] : {:index => 0}
    end
    
  end
end
