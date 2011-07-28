module PageObject
  module Elements
    class Form < Element
      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected

      def include_platform_for platform
        super
        if platform[:platform] == :watir
          require 'page-object/platforms/watir/form'
          self.class.send :include, PageObject::Platforms::Watir::Form
        elsif platform[:platform] == :selenium
          require 'page-object/platforms/selenium/form'
          self.class.send :include, PageObject::Platforms::Selenium::Form
        else
          raise ArgumentError, "expect platform to be :watir or :selenium"
        end
      end
    end
  end
end