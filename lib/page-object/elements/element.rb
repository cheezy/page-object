require 'page-object/nested_elements'

module PageObject
  module Elements
    #
    # Contains functionality that is common across all elements.
    #
    # @see PageObject::Platforms::WatirWebDriver::Element for the Watir version of all common methods
    # @see PageObject::Platforms::SeleniumWebDriver::Element for the Selenium version of all common methods
    #
    class Element
      include ::PageObject::NestedElements

      attr_reader :element

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      #
      # click the element
      #
      def click
        element.click
      end



      #
      # return true if the element is enabled
      #
      def enabled?
        element.enabled?
      end

      #
      # return true if the element is not enabled
      #
      def disabled?
        not enabled?
      end

      #
      # get the value of the given CSS property
      #
      def style(property)
        element.style property
      end

      def inspect
        element.inspect
      end

      #
      # retrieve the class name for an element
      #
      def class_name
        attribute 'class'
      end

      #
      # specify plural form of element
      #
      def self.plural_form
        "#{self.to_s.split('::')[-1].
            gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
            gsub(/([a-z\d])([A-Z])/,'\1_\2').
            tr("-", "_").
            downcase}s"
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

      # @private
      # delegate calls to driver element
      def method_missing(*args, &block)
        m = args.shift
        $stderr.puts "*** DEPRECATION WARNING"
        $stderr.puts "*** You are calling a method named #{m} at #{caller[0]}."
        $stderr.puts "*** This method does not exist in page-object so it is being passed to the driver."
        $stderr.puts "*** This feature will be removed in the near future."
        $stderr.puts "*** Please change your code to call the correct page-object method."
        $stderr.puts "*** If you are using functionality that does not exist in page-object please request it be added."
        begin
          element.send m, *args, &block
        rescue Exception => e
          raise
        end
      end

      protected

      def self.should_build_watir_xpath identifier
        ['table', 'span', 'div', 'td', 'li', 'ul', 'ol', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'label', 'area', 'canvas', 'audio', 'video', 'b', 'i'].include? identifier[:tag_name] and identifier[:name]
      end

      def self.build_xpath_for identifier
        tag_locator = identifier.delete(:tag_name)
        idx = identifier.delete(:index)
        if tag_locator == 'input' and identifier[:type] == 'submit'
          identifier.delete(:type)
          btn_ident = identifier.clone
          if btn_ident[:value]
            btn_ident[:text] = btn_ident[:value]
            btn_ident.delete(:value)
          end
          xpath = ".//button"
          xpath << "[#{attribute_expression(btn_ident)}]" unless btn_ident.empty?
          xpath = "(#{xpath})[#{idx+1}]" if idx
          identifier[:type] = %w[button reset submit image]
          xpath << " | .//input"
        else
          xpath = ".//#{tag_locator}"
        end
        xpath << "[#{attribute_expression(identifier)}]" unless identifier.empty?
        xpath = "(#{xpath})[#{idx+1}]" if idx
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
        return how => what if find_by.include? how or how == :tag_name
        return find_by_mapping[how] => what if find_by_mapping[how]
        identifier
      end

      def self.watir_finders
        [:class, :id, :index, :name, :xpath]
      end

      def self.watir_mapping
        {}
      end

      def self.selenium_finders
        [:class, :css, :id, :index, :name, :xpath]
      end

      def self.selenium_mapping
        {}
      end

      def include_platform_for platform
        if platform[:platform] == :watir_webdriver
          self.class.send :include,  ::PageObject::Platforms::WatirWebDriver::Element
          @platform = ::PageObject::Platforms::WatirWebDriver::PageObject.new(@element)
        elsif platform[:platform] == :selenium_webdriver
          self.class.send :include, ::PageObject::Platforms::SeleniumWebDriver::Element
          @platform = ::PageObject::Platforms::SeleniumWebDriver::PageObject.new(@element)
        else
          raise ArgumentError, "expect platform to be :watir_webdriver or :selenium_webdriver"
        end
      end

      def to_ary
        nil
      end
    end
  end
end
