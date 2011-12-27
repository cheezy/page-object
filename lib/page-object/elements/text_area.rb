
module PageObject
  module Elements
    class TextArea < Element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected

      def self.watir_finders
        super + [:tag_name]
      end

      def self.watir_mapping
        super.merge({:css => :tag_name})
      end

      def self.selenium_finders
        super + [:css]
      end

      def self.selenium_mapping
        super.merge({:tag_name => :css})
      end

      def include_platform_for platform
        super
        if platform[:platform] == :watir_webdriver
          require 'page-object/platforms/watir_webdriver/text_area'
          self.class.send :include, PageObject::Platforms::WatirWebDriver::TextArea
        elsif platform[:platform] == :selenium_webdriver
          require 'page-object/platforms/selenium_webdriver/text_area'
          self.class.send :include, PageObject::Platforms::SeleniumWebDriver::TextArea
        else
          raise ArgumentError, "expect platform to be :watir_webdriver or :selenium_webdriver"
        end
      end
    end

    ::PageObject::Elements.tag_to_class[:textarea] = ::PageObject::Elements::TextArea
    
  end
end
