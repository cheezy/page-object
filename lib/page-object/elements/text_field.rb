
module PageObject
  module Elements
    class TextField < Element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      def append(text)
        element.send_keys text
      end

      protected

      def self.watir_finders
        super + [:title, :value, :text, :label]
      end

      def self.selenium_finders
        super + [:title, :value, :text, :label]
      end

    end

    ::PageObject::Elements.type_to_class[:text] = ::PageObject::Elements::TextField
    ::PageObject::Elements.type_to_class[:password] = ::PageObject::Elements::TextField
  end
end
