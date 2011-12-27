module PageObject
  module Elements
    class TableCell < Element

      protected

      def self.watir_finders
        super + [:text]
      end

      def self.selenium_finders
        super + [:text]
      end

    end

    ::PageObject::Elements.tag_to_class[:td] = ::PageObject::Elements::TableCell
    ::PageObject::Elements.tag_to_class[:th] = ::PageObject::Elements::TableCell
    
  end
end
