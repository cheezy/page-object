
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

      def include_platform_for platform
        super
        if platform[:platform] == :watir_webdriver
          require 'page-object/platforms/watir_webdriver/ordered_list'
          self.class.send :include, PageObject::Platforms::WatirWebDriver::OrderedList
        elsif platform[:platform] == :selenium_webdriver
          require 'page-object/platforms/selenium_webdriver/ordered_list'
          self.class.send :include, PageObject::Platforms::SeleniumWebDriver::OrderedList
        else
          raise ArgumentError, "expect platform to be :watir_webdriver or :selenium_webdriver"
        end
      end

    end

    ::PageObject::Elements.tag_to_class[:ol] = ::PageObject::Elements::OrderedList
  end
end
