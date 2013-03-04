
module PageObject
  module Elements
    class RadioButton < Element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected

      def self.watir_finders
        super + [:value, :label]
      end

      def self.selenium_finders
        super + [:value, :label]
      end

      def include_platform_for platform
        super
        if platform[:platform] == :watir_webdriver
          require 'page-object/platforms/watir_webdriver/radio_button'
          self.class.send :include, PageObject::Platforms::WatirWebDriver::RadioButton
        elsif platform[:platform] == :selenium_webdriver
          require 'page-object/platforms/selenium_webdriver/radio_button'
          self.class.send :include, PageObject::Platforms::SeleniumWebDriver::RadioButton
        else
          raise ArgumentError, "expect platform to be :watir_webdriver or :selenium_webdriver"
        end
      end
    end

    ::PageObject::Elements.type_to_class[:radio] = ::PageObject::Elements::RadioButton
  end
end
