require 'mixology'

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
        if platform[:platform] == :watir_webdriver
          require 'page-object/platforms/watir_webdriver/check_box'
          self.mixin PageObject::Platforms::WatirWebDriver::CheckBox
        elsif platform[:platform] == :selenium_webdriver
          require 'page-object/platforms/selenium_webdriver/check_box'
          self.mixin PageObject::Platforms::SeleniumWebDriver::CheckBox
        else
          raise ArgumentError, "expect platform to be :watir_webdriver or :selenium_webdriver"
        end
      end
    end
  end
end