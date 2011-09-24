require 'mixology'

module PageObject
  module Elements
    class Image < Element
      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected

      def include_platform_for platform
        super
        if platform[:platform] == :watir_webdriver
          require 'page-object/platforms/watir_webdriver/image'
          self.mixin PageObject::Platforms::WatirWebDriver::Image
        elsif platform[:platform] == :selenium_webdriver
          require 'page-object/platforms/selenium_webdriver/image'
          self.mixin PageObject::Platforms::SeleniumWebDriver::Image
        else
          raise ArgumentError, "expect platform to be :watir_webdriver or :selenium_webdriver"
        end
      end

    end
  end
end