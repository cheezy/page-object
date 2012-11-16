module PageObject
  module Elements
    class Span < Element

      protected

      def self.watir_finders
        [:class, :id, :index, :text, :title, :xpath]
      end
      
      def self.selenium_finders
        [:class, :css, :id, :name, :text, :title, :xpath, :index]
      end
    end

    ::PageObject::Elements.tag_to_class[:span] = ::PageObject::Elements::Span
    
  end
end
