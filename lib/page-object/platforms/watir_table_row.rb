module PageObject
  module Platforms
    module WatirTableRow
      
      def [](idx)
        element = @element[idx]
        PageObject::Elements::TableCell.new(element, :platform => :watir)
      end
    end
  end
end