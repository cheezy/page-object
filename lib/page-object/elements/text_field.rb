module PageObject
  module Elements
    class TextField
      include Element

      WATIR_FIND_BY = [:class, :id, :index, :name, :tag_name, :text, :value, :xpath]
      SELENIUM_FIND_BY = [:class, :css, :id, :name, :xpath]

      WATIR_FIND_BY_MAPPING = {
        :css => :tag_name
      }

      SELENIUM_FIND_BY_MAPPING = {
        :tag_name => :css
      }

      def self.watir_identifier_for identifier
        identifier_for identifier, WATIR_FIND_BY, WATIR_FIND_BY_MAPPING
      end

      def self.selenium_identifier_for identifier
        identifier = identifier_for identifier, SELENIUM_FIND_BY, SELENIUM_FIND_BY_MAPPING
        return identifier.keys.first, identifier.values.first
      end
    end
  end
end