module PageObject
  module Elements
    class Div < Element

      protected

      def self.watir_finders
        super + [:text, :title]
      end
      
      def self.selenium_finders
        super + [:text, :title]
      end
      
    end

    ::PageObject::Elements.tag_to_class[:div] = ::PageObject::Elements::Div
  end
end
