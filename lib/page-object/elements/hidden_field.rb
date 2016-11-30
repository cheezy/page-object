module PageObject
  module Elements
    class HiddenField < Element

      def click
        raise "click is not available on the hidden field element"
      end

      protected

      def self.watir_finders
        super + [:text, :value]
      end

      def self.selenium_finders
        super + [:value]
      end
    end

    ::PageObject::Elements.type_to_class[:hidden] = ::PageObject::Elements::HiddenField
  end
end
