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
          Object::PageObject::Elements::ListItem.new(children[idx], :platform => @platform.class::PLATFORM_NAME)
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
            Object::PageObject::Elements::ListItem.new(obj, :platform => :watir_webdriver)
          end
        end

        private

        def children
          element.uls(:xpath => child_xpath)
        end
        
      end
    end
  end
end
