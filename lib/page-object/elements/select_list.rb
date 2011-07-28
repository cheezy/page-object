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
        super + [:text, :value]
      end

      def include_platform_for platform
        super
        if platform[:platform] == :watir
          require 'page-object/platforms/watir/select_list'
          self.class.send :include, PageObject::Platforms::Watir::SelectList
        elsif platform[:platform] == :selenium
          require 'page-object/platforms/selenium/select_list'
          self.class.send :include, PageObject::Platforms::Selenium::SelectList
        else
          raise ArgumentError, "expect platform to be :watir or :selenium"
        end
      end

    end
  end
end
