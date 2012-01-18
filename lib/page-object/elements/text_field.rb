
module PageObject
  module Elements
    class TextField < Element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      def append(text)
        @element.send_keys text
      end

      protected

      def self.watir_finders
        super + [:tag_name, :title]
      end

      def self.watir_mapping
        super.merge({:css => :tag_name})
      end

      def self.selenium_finders
        super + [:css, :title]
      end

      def self.selenium_mapping
        super.merge({:tag_name => :css})
      end

      def include_platform_for platform
        super
        if platform[:platform] == :watir_webdriver
          require 'page-object/platforms/watir_webdriver/text_field'
          self.class.send :include, PageObject::Platforms::WatirWebDriver::TextField
        elsif platform[:platform] == :selenium_webdriver
          require 'page-object/platforms/selenium_webdriver/text_field'
          self.class.send :include, PageObject::Platforms::SeleniumWebDriver::TextField
        else
          raise ArgumentError, "expect platform to be :watir_webdriver or :selenium_webdriver"
        end
      end
    end

    ::PageObject::Elements.type_to_class[:text] = ::PageObject::Elements::TextField
    ::PageObject::Elements.type_to_class[:password] = ::PageObject::Elements::TextField
  end
end
