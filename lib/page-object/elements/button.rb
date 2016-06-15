
module PageObject
  module Elements
    class Button < Element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      protected

      def self.watir_finders
        super + [:text, :value, :src, :alt, :css]
      end

      def self.selenium_finders
        super + [:value, :src, :alt]
      end

    end

    ::PageObject::Elements.type_to_class[:submit] = ::PageObject::Elements::Button
    ::PageObject::Elements.type_to_class[:image] = ::PageObject::Elements::Button
    ::PageObject::Elements.type_to_class[:button] = ::PageObject::Elements::Button
    ::PageObject::Elements.type_to_class[:reset] = ::PageObject::Elements::Button
  end
end
