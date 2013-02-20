
module PageObject
  module Elements
    class TableRow < Element
      include Enumerable

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

      #
      # iterator that yields with a PageObject::Elements::TableCell
      #
      # @return [PageObject::Elements::TableCell]
      #
      def each
        for index in 1..self.columns do
          yield self[index-1]
        end
      end

      protected

      def child_xpath
        ".//child::td|th"
      end

      def initialize_cell(row_element, platform)
        ::PageObject::Elements::TableCell.new(row_element, platform)
      end


      def include_platform_for platform
        super
        if platform[:platform] == :watir_webdriver
          require 'page-object/platforms/watir_webdriver/table_row'
          self.class.send :include, PageObject::Platforms::WatirWebDriver::TableRow
        elsif platform[:platform] == :selenium_webdriver
          require 'page-object/platforms/selenium_webdriver/table_row'
          self.class.send :include, PageObject::Platforms::SeleniumWebDriver::TableRow
        else
          raise ArgumentError, "expect platform to be :watir_webdriver or :selenium_webdriver"
        end
      end
    end

    ::PageObject::Elements.tag_to_class[:tr] = ::PageObject::Elements::TableRow
  end
end
