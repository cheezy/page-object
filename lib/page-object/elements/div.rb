module PageObject
  module Elements
    class Div < Element

      protected

      def self.watir_finders
        [:class, :id, :name, :text, :index, :xpath]
      end
      
      def self.selenium_finders
        [:class, :id, :name, :text, :xpath, :index]
      end
      
    end

    ::PageObject::Elements.tag_to_class[:div] = ::PageObject::Elements::Div
  end
end
