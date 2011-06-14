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
        eles = @element.find_elements(:xpath, child_xpath)
        PageObject::Elements::ListItem.new(eles[idx], :platform => :selenium)
      end
      
    end
  end
end