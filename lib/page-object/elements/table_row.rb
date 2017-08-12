require 'watir/elements/html_elements'

module PageObject
  module Elements
    class TableRow < Element
      include Enumerable

      #
      # iterator that yields with a PageObject::Elements::TableCell
      #
      def each(&block)
        cell_items.each(&block)
      end

      #
      # Return the PageObject::Elements::TableCell for the index provided.  Index
      # is zero based.  If the index provided is a String then it
      # will be matched with the text from the columns in the first row.
      # The text can be a substring of the full column text.
      #
      def [](what)
        idx = find_index(what)
        idx && cell_items[idx]
      end

      #
      # Returns the number of columns in the table.
      #
      def columns
        cell_items.size
      end

      protected

      def cell_items
        @cell_items ||= element.cells.map do |obj|
          ::PageObject::Elements::TableCell.new(obj)
        end
      end

      def find_index(what)
        return what if what.is_a? Integer

        parent(tag_name: 'table').headers.find_index do |header|
          header.text.include? what
        end
      end
    end

    ::PageObject::Elements.tag_to_class[:tr] = ::PageObject::Elements::TableRow
  end
end
