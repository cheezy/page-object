module PageObject
  module Elements
    class Link
      include Element

      WATIR_FIND_BY = [:class, :href, :id, :index, :name, :text, :xpath]
      SELENIUM_FIND_BY = [:class, :id, :link, :link_text, :name, :xpath]

      WATIR_FIND_BY_MAPPING = {
        :link => :text,
        :link_text => :text
      }

      SELENIUM_FIND_BY_MAPPING = {
        :text => :link_text
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