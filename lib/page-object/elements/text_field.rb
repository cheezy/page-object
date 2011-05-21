module PageObject
  module Elements
    class TextField < Element

      def self.watir_identifier_for identifier
        identifier_for identifier, watir_finders, watir_mapping
      end

      def self.selenium_identifier_for identifier
        identifier = identifier_for identifier, selenium_finders, selenium_mapping
        return identifier.keys.first, identifier.values.first
      end
      
      protected
      
      def self.watir_finders
        super + [:tag_name, :text, :value]
      end
      
      def self.watir_mapping
        super.merge({:css => :tag_name})
      end
      
      def self.selenium_finders
        super + [:css]
      end
      
      def self.selenium_mapping
        super.merge({:tag_name => :css})
      end
    end
  end
end