module PageObject
  module Platforms
    module SeleniumOrderedList
      
      #
      # Return the PageObject::Elements::ListItem for the index provided.  Index
      # is zero based.
      #
      # @return [PageObject::Elements::ListItem]
      #
      def [](idx)
        element = @element.find_element(:xpath, ".//li[#{idx+1}]")
        PageObject::Elements::ListItem.new(element, :platform => :selenium)
      end
      
    end
  end
end