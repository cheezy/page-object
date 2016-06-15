
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

    end

    ::PageObject::Elements.tag_to_class[:form] = ::PageObject::Elements::Form
  end
end
