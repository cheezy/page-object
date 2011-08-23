module PageObject
  module Platforms
    module WatirWebDriver
      module UnorderedList

        #
        # Return the PageObject::Elements::ListItem for the index provided.  Index
        # is zero based.
        #
        # @return [PageObject::Elements::ListItem]
        #
        def [](idx)
          eles = list_items
          Object::PageObject::Elements::ListItem.new(eles[idx], :platform => :watir)
        end

        #
        # Return the number of items contained in the unordered list
        #
        def items
          list_items.size
        end

        private

        def list_items
          element.wd.find_elements(:xpath, child_xpath)
        end

      end
    end
  end
end