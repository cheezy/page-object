module PageObject
  module Platforms
    module SeleniumWebDriver
      module OrderedList

        #
        # Return the PageObject::Elements::ListItem for the index provided.  Index
        # is zero based.
        #
        # @return [PageObject::Elements::ListItem]
        #
        def [](idx)
          Object::PageObject::Elements::ListItem.new(children[idx], :platform => :selenium_webdriver)
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
            Object::PageObject::Elements::ListItem.new(obj, :platform => :selenium_webdriver)
          end
        end

        private

        def children
          element.find_elements(:xpath, child_xpath)
        end

      end
    end
  end
end
