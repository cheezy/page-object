
module PageObject
  module Elements
    class OrderedList < Element
      include Enumerable

      def initialize(element, platform)
        @element = element
        include_platform_for platform
      end

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

      protected

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
