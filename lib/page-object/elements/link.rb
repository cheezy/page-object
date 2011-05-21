module PageObject
  module Elements
    class Link < Element
      
      def self.watir_identifier_for identifier
        identifier_for identifier, watir_finders, watir_mapping
      end

      def self.selenium_identifier_for identifier
        identifier = identifier_for identifier, selenium_finders, selenium_mapping
        return identifier.keys.first, identifier.values.first
      end    
      
      protected
      
      def self.watir_finders
        super + [:href, :text]
      end
      
      def self.watir_mapping
        super.merge({ :link => :text, :link_text => :text })
      end
      
      def self.selenium_finders
        super + [:link, :link_text]
      end
      
      def self.selenium_mapping
        super.merge(:text => :link_text)
      end

    end
  end
end