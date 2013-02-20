
module PageObject
  module Elements
    class Table < Element
      include Enumerable

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      #
      # iterator that yields with a PageObject::Elements::TableRow
      #
      # @return [PageObject::Elements::TableRow]
      #
      def each
        for index in 1..self.rows do
          yield self[index-1]
        end
      end

      #
      # return the first row
      #
      # @return PageObject::Elements::TableRow
      #
      def first_row
        self[0]
      end

      #
      # return the last row
      #
      # @return PageObject::Elements::TableRow
      #
      def last_row
        self[-1]
      end

      protected

      def child_xpath
        ".//child::tr"
      end

      def initialize_row(row_element, platform)
        ::PageObject::Elements::TableRow.new(row_element, platform)
      end


      def include_platform_for platform
        super
        if platform[:platform] == :watir_webdriver
          require 'page-object/platforms/watir_webdriver/table'
          self.class.send :include, PageObject::Platforms::WatirWebDriver::Table
        elsif platform[:platform] == :selenium_webdriver
          require 'page-object/platforms/selenium_webdriver/table'
          self.class.send :include, PageObject::Platforms::SeleniumWebDriver::Table
        else
          raise ArgumentError, "expect platform to be :watir_webdriver or :selenium_webdriver"
        end
      end
    end

    ::PageObject::Elements.tag_to_class[:table] = ::PageObject::Elements::Table
  end
end
