module PageObject
  module Platforms
    module Selenium

      module TableRow

        #
        # Return the PageObject::Elements::TableCell for the index provided.  Index
        # is zero based.
        #
        def [](idx)
          els = table_cells
          Object::PageObject::Elements::TableCell.new(els[idx], :platform => :selenium)
        end

        #
        # Returns the number of columns in the table.
        #
        def columns
          table_cells.size
        end

        private

        def table_cells
          element.find_elements(:xpath, child_xpath)
        end

      end
    end
  end
end