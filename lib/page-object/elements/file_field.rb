
module PageObject
  module Elements
    class FileField < Element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected

      def self.watir_finders
        super + [:title, :label]
      end

      def self.selenium_finders
        super + [:title, :label]
      end

      def include_platform_for platform
        super
        if platform[:platform] == :watir_webdriver
          require 'page-object/platforms/watir_webdriver/file_field'
          self.class.send :include, PageObject::Platforms::WatirWebDriver::FileField
        elsif platform[:platform] == :selenium_webdriver
          require 'page-object/platforms/selenium_webdriver/file_field'
          self.class.send :include, PageObject::Platforms::SeleniumWebDriver::FileField
        else
          raise ArgumentError, "expect platform to be :watir_webdriver or :selenium_webdriver"
        end
      end
    end

    ::PageObject::Elements.type_to_class[:file] = ::PageObject::Elements::FileField

  end
end
