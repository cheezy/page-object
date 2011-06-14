module PageObject
  module Platforms
    module SeleniumTable      
      
      #
      # Return the PageObject::Elements::TableRow for the index provided.  Index
      # is zero based.
      #
      def [](idx)
        eles = @element.find_elements(:xpath, child_xpath)
        PageObject::Elements::TableRow.new(eles[idx], :platform => :selenium)
      end

      #
      # Returns the number of rows in the table.
      #
      def rows
        element.find_elements(:xpath, child_xpath).size
      end
 
      #
      # override PageObject::Platforms::SeleniumElement because exists? is not
      # available on a table element in Selenium.
      #
      def exists?
        raise "exists? not available on table element"
      end
      
    end
  end
end