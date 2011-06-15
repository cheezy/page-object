module PageObject
  module Platforms
    module SeleniumTable      
      
      #
      # Return the PageObject::Elements::TableRow for the index provided.  Index
      # is zero based.
      #
      # @return [PageObject::Elements::TableRow]
      #
      def [](idx)
        eles = table_rows
        PageObject::Elements::TableRow.new(eles[idx], :platform => :selenium)
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
      
      def table_rows
        @element.find_elements(:xpath, child_xpath)
      end
    end
  end
end