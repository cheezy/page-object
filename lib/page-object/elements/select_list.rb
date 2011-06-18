module PageObject
  module Elements
    class SelectList < Element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected
      
      def self.watir_finders
        super + [:text, :value]
      end

      def include_platform_for platform
        super
        if platform[:platform] == :watir
          require 'page-object/platforms/watir_select_list'
          self.class.send :include, PageObject::Platforms::WatirSelectList
        elsif platform[:platform] == :selenium
          require 'page-object/platforms/selenium_select_list'
          self.class.send :include, PageObject::Platforms::SeleniumSelectList
        else
          raise ArgumentError, "expect platform to be :watir or :selenium"          
        end
      end

    end
  end
end
