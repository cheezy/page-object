
module PageObject
  module Elements
    class SelectList < Element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected

      def child_xpath
        ".//child::option"
      end

      def self.watir_finders
        super + [:text, :value, :label]
      end

      def self.selenium_finders
        super + [:label]
      end

      def include_platform_for platform
        super
        if platform[:platform] == :watir_webdriver
          require 'page-object/platforms/watir_webdriver/select_list'
          self.class.send :include, PageObject::Platforms::WatirWebDriver::SelectList
        elsif platform[:platform] == :selenium_webdriver
          require 'page-object/platforms/selenium_webdriver/select_list'
          self.class.send :include, PageObject::Platforms::SeleniumWebDriver::SelectList
        else
          raise ArgumentError, "expect platform to be :watir_webdriver or :selenium_webdriver"
        end
      end

    end

    ::PageObject::Elements.tag_to_class[:select] = ::PageObject::Elements::SelectList
  end
end
