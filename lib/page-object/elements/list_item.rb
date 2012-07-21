module PageObject
  module Elements
    class ListItem < Element

      protected

      def self.watir_finders
        super + [:text]
      end

      def self.selenium_finders
        super + [:text]
      end
    end

    ::PageObject::Elements.tag_to_class[:li] = ::PageObject::Elements::ListItem
    
  end
end
