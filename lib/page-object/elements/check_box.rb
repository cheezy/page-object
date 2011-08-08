module PageObject
  module Elements
    class CheckBox < Element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected
      
      def include_platform_for platform
        super
        if platform[:platform] == :watir
          require 'page-object/platforms/watir/check_box'
          self.class.send :include, PageObject::Platforms::Watir::CheckBox
        elsif platform[:platform] == :selenium
          require 'page-object/platforms/selenium/check_box'
          self.class.send :include, PageObject::Platforms::Selenium::CheckBox
        else
          raise ArgumentError, "expect platform to be :watir or :selenium"
        end
      end
    end
  end
end