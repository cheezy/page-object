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

      def include_platform_for platform
        super
        if platform[:platform] == :watir
          require 'page-object/platforms/watir/table_row'
          self.class.send :include, PageObject::Platforms::Watir::TableRow
        elsif platform[:platform] == :selenium
          require 'page-object/platforms/selenium/table_row'
          self.class.send :include, PageObject::Platforms::Selenium::TableRow
        else
          raise ArgumentError, "expect platform to be :watir or :selenium"
        end
      end
    end
  end
end