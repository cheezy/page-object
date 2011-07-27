module PageObject
  module Elements
    class Button < Element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected

      def self.watir_finders
        super + [:text]
      end

      def include_platform_for platform
        super
        if platform[:platform] == :selenium
          require 'page-object/platforms/selenium/button'
          self.class.send :include, PageObject::Platforms::Selenium::Button
        end
      end
    end
  end
end