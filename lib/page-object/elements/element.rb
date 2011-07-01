
module PageObject
  module Elements
    #
    # Contains functionality that is common across all elements.
    #
    # @see PageObject::Platforms::WatirElement for the Watir version of all common methods
    # @see PageObject::Platforms::SeleniumElement for the Selenium version of all common methods
    #
    class Element
      attr_reader :element
      
      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end
      
      # @private
      def self.watir_identifier_for identifier
        if should_build_watir_xpath(identifier)
          how = :xpath
          what = build_xpath_for(identifier)
          return how => what
        end
        all_identities = {}
        identifier.each do |key, value|
          each = {key => value}
          ident = identifier_for each, watir_finders, watir_mapping
          all_identities[ident.keys.first] = ident.values.first
        end
        all_identities
      end
      
      def self.should_build_watir_xpath identifier
        ['table', 'span', 'div', 'td', 'li'].include? identifier[:tag_name] and identifier[:name]
      end

      # @private
      def self.selenium_identifier_for identifier
        if identifier.length == 1
          identifier = identifier_for identifier, selenium_finders, selenium_mapping
          return identifier.keys.first, identifier.values.first
        elsif identifier.length > 1
          how = :xpath
          what = build_xpath_for identifier
          return how, what
        end
      end

      protected
      
      def self.build_xpath_for identifier
        tag_locator = identifier.delete(:tag_name)
        idx = identifier.delete(:index)
        identifier.delete(:tag_name)
        xpath = ".//#{tag_locator}"
        xpath << "[#{attribute_expression(identifier)}]" unless identifier.empty?
        xpath << "[#{idx+1}]" if idx
        xpath
      end
      
      def self.attribute_expression(identifier)
        identifier.map do |key, value|
          if value.kind_of?(Array)
            "(" + value.map { |v| equal_pair(key, v) }.join(" or ") + ")"
          else
            equal_pair(key, value)
          end
        end.join(" and ")
      end
      
      def self.equal_pair(key, value)
        if key == :label
          "@id=//label[normalize-space()=#{xpath_string(value)}]/@for"
        else
          "#{lhs_for(key)}=#{xpath_string(value)}"
        end
      end
      
      def self.lhs_for(key)
        case key
        when :text, 'text'
          'normalize-space()'
        when :href
          'normalize-space(@href)'
        else
          "@#{key.to_s.gsub("_", "-")}"
        end
      end

      def self.xpath_string(value)
        if value.include? "'"
          parts = value.split("'", -1).map { |part| "'#{part}'" }
          string = parts.join(%{,"'",})
          "concat(#{string})"
        else
          "'#{value}'"
        end
      end

      def self.identifier_for identifier, find_by, find_by_mapping
        how, what = identifier.keys.first, identifier.values.first
        return how => what if find_by.include? how
        return find_by_mapping[how] => what if find_by_mapping[how]
        return nil => what
      end
      
      def self.watir_finders
        [:class, :id, :index, :name, :xpath]
      end
      
      def self.watir_mapping 
        {} 
      end
      
      def self.selenium_finders
        [:class, :id, :name, :xpath, :index]
      end
      
      def self.selenium_mapping 
        {} 
      end
      
      def include_platform_for platform
        if platform[:platform] == :watir
          require 'page-object/platforms/watir_element'
          self.class.send :include, PageObject::Platforms::WatirElement
        elsif platform[:platform] == :selenium
          require 'page-object/platforms/selenium_element'
          self.class.send :include, PageObject::Platforms::SeleniumElement
        else
          raise ArgumentError, "expect platform to be :watir or :selenium"          
        end
      end
    end
  end
end
