
module PageObject
  module Elements
    class TableRow < Element
      include Enumerable

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

      #
      # Return the PageObject::Elements::TableCell for the index provided.  Index
      # is zero based.  If the index provided is a String then it
      # will be matched with the text from the columns in the first row.
      # The text can be a substring of the full column text.
      #
      def [](idx)
        idx = find_index_by_title(idx) if idx.kind_of?(String)
        return nil unless idx && columns >= idx + 1
        initialize_cell(element[idx], :platform => :watir)
      end

      #
      # Returns the number of columns in the table.
      #
      def columns
        element.wd.find_elements(:xpath, child_xpath).size
      end

      protected

      def child_xpath
        ".//child::td|th"
      end

      def initialize_cell(row_element, platform)
        ::PageObject::Elements::TableCell.new(row_element, platform)
      end

      def find_index_by_title(title)
        table = element.parent
        table = table.parent if table.tag_name == 'tbody'
        first_row = table[0]
        first_row.cells.find_index {|column| column.text.include? title }
      end

    end

    ::PageObject::Elements.tag_to_class[:tr] = ::PageObject::Elements::TableRow
  end
end
