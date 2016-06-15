
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

    end

    ::PageObject::Elements.tag_to_class[:tr] = ::PageObject::Elements::TableRow
  end
end
