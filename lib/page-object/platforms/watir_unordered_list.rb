module PageObject
  module Platforms
    module WatirUnorderedList
      
      #
      # Return the PageObject::Elements::ListItem for the index provided.  Index
      # is zero based.
      #
      # @return [PageObject::Elements::ListItem]
      #
      def [](idx)
        element = @element.wd.find_element(:xpath, ".//li[#{idx+1}]")
        PageObject::Elements::ListItem.new(element, :platform => :watir)
      end
      
    end
  end
end