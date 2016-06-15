
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

    end

    ::PageObject::Elements.tag_to_class[:select] = ::PageObject::Elements::SelectList
  end
end
