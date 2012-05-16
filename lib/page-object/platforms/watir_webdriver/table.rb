module PageObject
  module Platforms
    module WatirWebDriver

      module Table

        #
        # Return the PageObject::Elements::TableRow for the index provided.  Index
        # is zero based.  If the index provided is a String then it
        # will be matched with the text from the first column.
        #
        # @return [PageObject::Elements::TableRow]
        #
        def [](idx)
          idx = find_index_by_title(idx) if idx.kind_of?(String)
          Object::PageObject::Elements::TableRow.new(element[idx], :platform => :watir_webdriver)
        end

        #
        # Returns the number of rows in the table.
        #
        def rows
          element.wd.find_elements(:xpath, child_xpath).size
        end

        private

        def find_index_by_title(row_title)
          element.rows.find_index {|row| row[0].text == row_title}
        end

      end
    end
  end
end
