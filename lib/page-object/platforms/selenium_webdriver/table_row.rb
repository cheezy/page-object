module PageObject
  module Platforms
    module SeleniumWebDriver

      module TableRow

        #
        # Return the PageObject::Elements::TableCell for the index provided.  Index
        # is zero based.  If the index provided is a String then it
        # will be matched with the text from the columns in the first row.
        # The text can be a substring of the full column text.
        #
        def [](idx)
          els = table_cells
          idx = find_index_by_title(idx) if idx.kind_of?(String)
          return nil unless idx  && columns >= idx + 1
          initialize_cell(els[idx], :platform => @platform.class::PLATFORM_NAME)
        end

        #
        # Returns the number of columns in the table.
        #
        def columns
          table_cells.size
        end

        private

        def find_index_by_title(title)
          table = parent
          parent_tag_name = parent.element.tag_name
          table = table.parent if (parent_tag_name == 'tbody' || parent_tag_name == 'thead')
          table[0].find_index { |column| column.text.include? title }
        end

        def table_cells
          element.find_elements(:xpath, child_xpath)
        end

      end
    end
  end
end
