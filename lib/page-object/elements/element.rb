
module PageObject
  module Elements
    #
    # Contains functionality that is common across all elements.
    #
    # @see PageObject::Elements::WatirElement for the Watir version of all common methods
    # @see PageObject::Elements::SeleniumElement for the Selenium version of all common methods
    #
    class Element
      attr_reader :element
      
      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end
      
      # @private
      def self.watir_identifier_for identifier
        identifier_for identifier, watir_finders, watir_mapping
      end

      # @private
      def self.selenium_identifier_for identifier
        identifier = identifier_for identifier, selenium_finders, selenium_mapping
        return identifier.keys.first, identifier.values.first
      end
      
      protected

      def self.identifier_for identifier, find_by, find_by_mapping
        how, what = identifier.keys.first, identifier.values.first
        return how => what if find_by.include? how
        return find_by_mapping[how] => what if find_by_mapping[how]
        return nil => what
      end
      
      def self.watir_finders
        [:class, :id, :index, :name, :xpath]
      end
      
      def self.watir_mapping 
        {} 
      end
      
      def self.selenium_finders
        [:class, :id, :name, :xpath]
      end
      
      def self.selenium_mapping 
        {} 
      end
      
      def include_platform_for platform
        if platform[:platform] == :watir
          require 'page-object/platforms/watir_element'
          self.class.send :include, PageObject::Platforms::WatirElement
        elsif platform[:platform] == :selenium
          require 'page-object/platforms/selenium_element'
          self.class.send :include, PageObject::Platforms::SeleniumElement
        else
          raise ArgumentError, "expect platform to be :watir or :selenium"          
        end
      end
    end
  end
end