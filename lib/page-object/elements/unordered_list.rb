
module PageObject
  module Elements
    class UnorderedList < Element
      include Enumerable

      #
      # iterator that yields with a PageObject::Elements::ListItem
      #
      # @return [PageObject::Elements::ListItem]
      #
      def each
        for index in 1..self.items do
          yield self[index-1]
        end
      end

      #
      # Return the PageObject::Elements::ListItem for the index provided.  Index
      # is zero based.
      #
      # @return [PageObject::Elements::ListItem]
      #
      def [](idx)
        Object::PageObject::Elements::ListItem.new(children[idx])
      end

      #
      # Return the number of items contained in the unordered list
      #
      def items
        children.size
      end

      #
      # Return the ListItem objects that are children of the
      # UnorderedList
      #
      def list_items
        children.collect do |obj|
          Object::PageObject::Elements::ListItem.new(obj)
        end
      end

      protected

      def child_xpath
        "./child::li"
      end

      def children
        element.uls(:xpath => child_xpath)
      end

    end

    ::PageObject::Elements.tag_to_class[:ul] = ::PageObject::Elements::UnorderedList
    
  end
end
