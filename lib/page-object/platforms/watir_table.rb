module PageObject
  module Platforms
    module WatirTable
      
      #
      # Return the PageObject::Elements::TableRow for the index provided.  Index
      # is zero based.
      #
      def [](idx)
        PageObject::Elements::TableRow.new(@element[idx], :platform => :watir)
      end
      
    end
  end
end