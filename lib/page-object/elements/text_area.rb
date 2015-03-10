
module PageObject
  module Elements
    class TextArea < Element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      def self.watir_finders
        super + [:label]
      end

      def self.selenium_finders
        super + [:label]
      end

    end

    ::PageObject::Elements.tag_to_class[:textarea] = ::PageObject::Elements::TextArea

  end
end
