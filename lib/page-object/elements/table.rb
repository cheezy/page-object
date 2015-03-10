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

      #
      # return the table as hashes
      #
      # @return Hash
      #
      def hashes
        headers = self.first_row.map(&:text)
        self.entries[1..-1].map do |row|
          Hash[headers.zip(row.map(&:text))]
        end
      end

      protected

      def child_xpath
        ".//child::tr"
      end

      def initialize_row(row_element, platform)
        ::PageObject::Elements::TableRow.new(row_element, platform)
      end

    end

    ::PageObject::Elements.tag_to_class[:table] = ::PageObject::Elements::Table
  end
end
