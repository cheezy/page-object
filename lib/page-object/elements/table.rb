module PageObject
  module Elements
    class Table < Element
      include Enumerable

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

      #
      # Return the PageObject::Elements::TableRow for the index provided.  Index
      # is zero based.  If the index provided is a String then it
      # will be matched with the text from any column. The text can be a substring of the full column text.
      #
      # @return [PageObject::Elements::TableRow]
      #
      def [](idx)
        idx = find_index_by_title(idx) if idx.kind_of?(String)
        return nil unless idx
        initialize_row(element[idx], :platform => :watir)
      end

      #
      # Returns the number of rows in the table.
      #
      def rows
        element.wd.find_elements(:xpath, child_xpath).size
      end

      protected

      def child_xpath
        ".//child::tr"
      end

      def initialize_row(row_element, platform)
        ::PageObject::Elements::TableRow.new(row_element, platform)
      end

      def find_index_by_title(row_title)
        element.rows.find_index do |row|
          row.cells.any? { |col| col.text.include? row_title }
        end
      end

    end

    ::PageObject::Elements.tag_to_class[:table] = ::PageObject::Elements::Table
  end
end
