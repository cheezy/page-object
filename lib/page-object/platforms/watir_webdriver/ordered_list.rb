module PageObject
  module Platforms
    module WatirWebDriver
      module OrderedList

        #
        # Return the PageObject::Elements::ListItem for the index provided.  Index
        # is zero based.
        #
        # @return [PageObject::Elements::ListItem]
        #
        def [](idx)
          items = list_items.find_all { |item| item.parent == element }
          Object::PageObject::Elements::ListItem.new(items[idx], :platform => :watir_webdriver)
        end

        #
        # Return the number of items contained in the ordered list
        #
        def items
          list_items.size
        end

        private

        def list_items
          element.ols(:xpath => child_xpath)
        end
      end
    end
  end
end
