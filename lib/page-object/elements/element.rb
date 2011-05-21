module PageObject
  module Elements

    #
    # Contains functionality that is common across all elements.
    #
    class Element
      
      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end
      
      def self.identifier_for identifier, find_by, find_by_mapping
        how, what = identifier.keys.first, identifier.values.first
        return how => what if find_by.include? how
        return find_by_mapping[how] => what if find_by_mapping[how]
        return nil => what
      end
      
      protected

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
      
      private
      
      def include_platform_for platform
        if platform[:platform] == :watir
          require 'page-object/watir_element'
          self.class.send :include, PageObject::WatirElement
        else
          require 'page-object/selenium_element'
          self.class.send :include, PageObject::SeleniumElement
        end
      end
    end
  end
end