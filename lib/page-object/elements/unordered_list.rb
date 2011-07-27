module PageObject
  module Elements
    class UnorderedList < Element
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
        ".//child::li"
      end

      def self.watir_finders
        [:class, :id, :index, :xpath]
      end

      def include_platform_for platform
        super
        if platform[:platform] == :watir
          require 'page-object/platforms/watir/unordered_list'
          self.class.send :include, PageObject::Platforms::Watir::UnorderedList
        elsif platform[:platform] == :selenium
          require 'page-object/platforms/selenium_unordered_list'
          self.class.send :include, PageObject::Platforms::SeleniumUnorderedList
        else
          raise ArgumentError, "expect platform to be :watir or :selenium"
        end
      end

    end
  end
end