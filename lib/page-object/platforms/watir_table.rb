module PageObject
  module Platforms
    module WatirTable
      
      #
      # Return the PageObject::Elements::TableRow for the index provided.  Index
      # is zero based.
      #
      # @return [PageObject::Elements::TableRow]
      #
      def [](idx)
        PageObject::Elements::TableRow.new(@element[idx], :platform => :watir)
      end
      
      #
      # Returns the number of rows in the table.
      #
      def rows
        element.wd.find_elements(:xpath, child_xpath).size
      end
      
    end
  end
end