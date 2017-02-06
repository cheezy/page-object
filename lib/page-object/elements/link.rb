
module PageObject
  module Elements
    class Link < Element

      protected

      def self.watir_finders
        super + [:href, :text, :css, :title]
      end

      def self.watir_mapping
        super.merge({:link => :text, :link_text => :text})
      end

    end
    
    ::PageObject::Elements.tag_to_class[:a] = ::PageObject::Elements::Link

  end
end
