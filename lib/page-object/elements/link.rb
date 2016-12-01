
module PageObject
  module Elements
    class Link < Element

      #
      # return the href for the link
      #
      def href
        element.href
      end

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
