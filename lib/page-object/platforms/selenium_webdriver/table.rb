module PageObject
  module Platforms
    module SeleniumWebDriver
      module Table

        #
        # Return the PageObject::Elements::TableRow for the index provided.  Index
        # is zero based.  If the index provided is a String then it
        # will be matched with the text from any column. The text can be a substring of the full column text.
        #
        # @return [PageObject::Elements::TableRow]
        #
        def [](idx)
          eles = table_rows
          idx = find_index_by_title(idx, eles) if idx.kind_of?(String)
          return nil unless idx
          Object::PageObject::Elements::TableRow.new(eles[idx], :platform => :selenium_webdriver)
        end

        #
        # Returns the number of rows in the table.
        #
        def rows
          table_rows.size
        end

        #
        # override PageObject::Platforms::SeleniumElement because exists? is not
        # available on a table element in Selenium.
        #
        def exists?
          raise "exists? not available on table element"
        end

        private

        def find_index_by_title(row_title, eles)
          eles.find_index do |row|
            columns = row.find_elements(:xpath, ".//child::td|th")
            columns.any? { |col| col.text.include? row_title }
          end
        end

        def table_rows
          element.find_elements(:xpath, child_xpath)
        end
      end
    end
  end
end
