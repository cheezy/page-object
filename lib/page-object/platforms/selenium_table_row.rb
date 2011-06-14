module PageObject
  module Platforms
    module SeleniumTableRow
      
      #
      # Return the PageObject::Elements::TableCell for the index provided.  Index
      # is zero based.
      #
      def [](idx)
        els = element.find_elements(:xpath, child_xpath)
        PageObject::Elements::TableCell.new(els[idx], :platform => :selenium)
      end
      
      #
      # Returns the number of columns in the table.
      #
      def columns
        element.find_elements(:xpath, child_xpath).size
      end
      
    end
  end
end