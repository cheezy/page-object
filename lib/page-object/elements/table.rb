module PageObject
  module Elements
    class Table < Element
      include Enumerable

      #
      # iterator that yields with a PageObject::Elements::TableRow
      #
      # @return [PageObject::Elements::TableRow]
      #
      def each(&block)
        row_items.each(&block)
      end

      alias_method :first_row, :first

      #
      # return the last row
      #
      # @return PageObject::Elements::TableRow
      #
      def last_row
        self[-1]
      end

      #
      # Return the PageObject::Elements::TableRow for the index provided.  Index
      # is zero based.  If the index provided is a String then it
      # will be matched with the text from any column. The text can be a substring of the full column text.
      #
      # @return [PageObject::Elements::TableRow]
      #
      def [](what)
        idx = find_index(what)
        idx && row_items[idx]
      end

      #
      # Returns the number of rows in the table.
      #
      def rows
        row_items.size
      end

      #
      # Returns the Array of values(String) in a column for the index provided. Index
      # is zero based. If the index provided is a String then it
      # will be matched with the text from the header. The text can be a substring of the full header text.
      #
      def column_values(what)
        idx = find_index_of_header(what)
        idx && row_items.drop(1).collect { |row| row.cell(index: idx).text }
      end

      protected

      def row_items
        meth = strategy == :descendants ? :trs : :rows
        @row_items ||= element.send(meth).map do |obj|
          ::PageObject::Elements::TableRow.new(obj)
        end
      end

      def strategy
        :children
      end

      def find_index_of_header(what)
        return what if what.is_a? Integer
        row_items[0].cells.find_index do |cell|
          cell.text.include? Regexp.escape(what)
        end
      end

      def find_index(what)
        return what if what.is_a? Integer
        row_items.find_index do |row|
          row.cell(text: /#{Regexp.escape(what)}/).exist?
        end
      end
    end

    ::PageObject::Elements.tag_to_class[:table] = ::PageObject::Elements::Table
  end
end
