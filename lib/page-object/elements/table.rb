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

      protected

      def child_xpath
        ".//child::tr"
      end

      def include_platform_for platform
        super
        if platform[:platform] == :watir
          require 'page-object/platforms/watir/table'
          self.class.send :include, PageObject::Platforms::Watir::Table
        elsif platform[:platform] == :selenium
          require 'page-object/platforms/selenium/table'
          self.class.send :include, PageObject::Platforms::Selenium::Table
        else
          raise ArgumentError, "expect platform to be :watir or :selenium"
        end
      end
    end
  end
end