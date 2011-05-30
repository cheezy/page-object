module PageObject
  module Platforms
    module WatirTableRow
      
      #
      # Return the PageObject::Elements::TableCell for the index provided.  Index
      # is zero based.
      #
      def [](idx)
        PageObject::Elements::TableCell.new(@element[idx], :platform => :watir)
      end
      
    end
  end
end