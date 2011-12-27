
module PageObject
  module Elements
    class Form < Element
      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected

      def self.watir_finders
        super + [:action]
      end

      def self.selenium_finders
        super + [:action]
      end

      def include_platform_for platform
        super
        if platform[:platform] == :watir_webdriver
          require 'page-object/platforms/watir_webdriver/form'
          self.class.send :include, PageObject::Platforms::WatirWebDriver::Form
        elsif platform[:platform] == :selenium_webdriver
          require 'page-object/platforms/selenium_webdriver/form'
          self.class.send :include,  PageObject::Platforms::SeleniumWebDriver::Form
        else
          raise ArgumentError, "expect platform to be :watir_webdriver or :selenium_webdriver"
        end
      end
    end

    ::PageObject::Elements.tag_to_class[:form] = ::PageObject::Elements::Form
  end
end
