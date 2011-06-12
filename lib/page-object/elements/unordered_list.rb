module PageObject
  module Elements
    class UnorderedList < Element
      
      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end
      
      protected
      
      def self.watir_finders
        [:class, :id, :index, :xpath]
      end

      def include_platform_for platform
        super
        if platform[:platform] == :watir
          require 'page-object/platforms/watir_unordered_list'
          self.class.send :include, PageObject::Platforms::WatirUnorderedList
        elsif platform[:platform] == :selenium
          require 'page-object/platforms/selenium_unordered_list'
          self.class.send :include, PageObject::Platforms::SeleniumUnorderedList
        else
          raise ArgumentError, "expect platform to be :watir or :selenium"          
        end
      end
  
    end
  end
end