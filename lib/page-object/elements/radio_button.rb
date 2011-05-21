module PageObject
  module Elements
    class RadioButton < Element

      def self.watir_identifier_for identifier
        identifier_for identifier, watir_finders, watir_mapping
      end

      def self.selenium_identifier_for identifier
        identifier = identifier_for identifier, selenium_finders, selenium_mapping
        return identifier.keys.first, identifier.values.first
      end
    end
  end
end