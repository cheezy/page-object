
module PageObject
  module Elements
    class OrderedList < Element
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
        Object::PageObject::Elements::ListItem.new(children[idx], :platform => :watir)
      end

      #
      # Return the number of items contained in the ordered list
      #
      def items
        children.size
      end

      #
      # Return the ListItem objects that are children of the OrderedList
      #
      def list_items
        children.collect do |obj|
          Object::PageObject::Elements::ListItem.new(obj, :platform => :watir)
        end
      end

      protected

      def children
        element.ols(:xpath => child_xpath)
      end

      def child_xpath
        "./child::li"
      end

      def self.watir_finders
        [:class, :id, :index, :xpath]
      end

    end

    ::PageObject::Elements.tag_to_class[:ol] = ::PageObject::Elements::OrderedList
  end
end
