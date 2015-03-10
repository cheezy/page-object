
module PageObject
  module Elements
    class RadioButton < Element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected

      def self.watir_finders
        super + [:value, :label]
      end

      def self.selenium_finders
        super + [:value, :label]
      end

    end

    ::PageObject::Elements.type_to_class[:radio] = ::PageObject::Elements::RadioButton
  end
end
