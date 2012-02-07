module PageObject
  module Platforms
    module SeleniumWebDriver
      module UnorderedList

        #
        # Return the PageObject::Elements::ListItem for the index provided.  Index
        # is zero based.
        #
        # @return [PageObject::Elements::ListItem]
        #
        def [](idx)
          children[idx]
        end

        #
        # Return the number of items contained in the unordered list
        #
        def items
          children.size
        end

        private

        def children
          items = list_items.map do |item|
            ::PageObject::Elements::ListItem.new(item, :platform => :selenium_webdriver)
          end
          items.find_all { |item| item.parent.element == element }
        end

        def list_items
          element.find_elements(:xpath, child_xpath)
        end

      end
    end
  end
end
