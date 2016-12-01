module PageObject
  module Elements
    class Span < Element

      protected

      def self.watir_finders
        [:class, :id, :index, :text, :title, :xpath]
      end
      
    end

    ::PageObject::Elements.tag_to_class[:span] = ::PageObject::Elements::Span
    
  end
end
