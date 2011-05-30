module PageObject
  module Platforms
    module SeleniumTableRow
      
      #
      # Return the PageObject::Elements::TableCell for the index provided.  Index
      # is zero based.
      #
      def [](idx)
        element = @element.find_element(:xpath, "./th|td[#{idx+1}]")
        PageObject::Elements::TableCell.new(element, :platform => :selenium)
      end
      
    end
  end
end