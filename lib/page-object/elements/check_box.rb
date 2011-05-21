module PageObject
  module Elements
    class CheckBox
      include Element

      WATIR_FIND_BY = [:class, :id, :index, :name, :xpath]
      SELENIUM_FIND_BY = [:class, :id, :name, :xpath]

      def self.watir_identifier_for identifier
        identifier_for identifier, WATIR_FIND_BY, {}
      end

      def self.selenium_identifier_for identifier
        identifier = identifier_for identifier, SELENIUM_FIND_BY, {}
        return identifier.keys.first, identifier.values.first
      end
    end
  end
end