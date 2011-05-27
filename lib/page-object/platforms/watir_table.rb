module PageObject
  module Platforms
    module WatirTable
      
      def [](idx)
        element = @element[idx]
        PageObject::Elements::TableRow.new(element, :platform => :watir)
      end
    end
  end
end