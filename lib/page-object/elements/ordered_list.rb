
module PageObject
  module Elements
    class OrderedList < Element
      include Enumerable

      #
      # iterator that yields with a PageObject::Elements::ListItem
      #
      # @return [PageObject::Elements::ListItem]
      #
      def each(&block)
        list_items.each(&block)
      end

      #
      # Return the PageObject::Elements::ListItem for the index provided.  Index
      # is zero based.
      #
      # @return [PageObject::Elements::ListItem]
      #
      def [](idx)
        list_items[idx]
      end

      #
      # Return the number of items contained in the ordered list
      #
      def items
        list_items.size
      end

      #
      # Return Array of ListItem objects that are children of the OrderedList
      #
      def list_items
        @list_items ||= children(tag_name: 'li')
      end
    end

    ::PageObject::Elements.tag_to_class[:ol] = ::PageObject::Elements::OrderedList
  end
end
