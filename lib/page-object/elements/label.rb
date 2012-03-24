module PageObject
  module Elements
    class Label < Element

      protected

      def self.watir_finders
        super + [:text]
      end

      def self.selenium_finders
        super + [:text]
      end

    end

    ::PageObject::Elements.tag_to_class[:label] = ::PageObject::Elements::Label
  end
end
