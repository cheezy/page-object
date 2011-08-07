module PageObject
  module Elements
    class TextField < Element

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
        if platform[:platform] == :watir
          require 'page-object/platforms/watir/text_field'
          self.class.send :include, PageObject::Platforms::Watir::TextField
        elsif platform[:platform] == :selenium
          require 'page-object/platforms/selenium/text_field'
          self.class.send :include, PageObject::Platforms::Selenium::TextField
        else
          raise ArgumentError, "expect platform to be :watir or :selenium"
        end
      end
    end
  end
end