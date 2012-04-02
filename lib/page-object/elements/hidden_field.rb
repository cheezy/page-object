module PageObject
  module Elements
    class HiddenField < Element

      def click
        raise "click is not available on hidden field element with Selenium or Watir"
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
