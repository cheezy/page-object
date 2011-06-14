module PageObject
  module Platforms
    module WatirOrderedList
      
      #
      # Return the PageObject::Elements::ListItem for the index provided.  Index
      # is zero based.
      #
      # @return [PageObject::Elements::ListItem]
      #
      def [](idx)
        eles = @element.wd.find_elements(:xpath, child_xpath)
        PageObject::Elements::ListItem.new(eles, :platform => :watir)
      end
      
    end
  end
end