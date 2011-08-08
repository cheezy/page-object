module PageObject
  module Elements
    class RadioButton < Element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected
      
      def include_platform_for platform
        super
        if platform[:platform] == :watir
          require 'page-object/platforms/watir/radio_button'
          self.class.send :include, PageObject::Platforms::Watir::RadioButton
        elsif platform[:platform] == :selenium
          require 'page-object/platforms/selenium/radio_button'
          self.class.send :include, PageObject::Platforms::Selenium::RadioButton
        else
          raise ArgumentError, "expect platform to be :watir or :selenium"
        end
      end
    end
  end
end
