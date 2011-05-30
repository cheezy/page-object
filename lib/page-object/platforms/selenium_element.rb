
module PageObject
  module Platforms
    module SeleniumElement
      
      #
      # return true if an element is visible
      #
      def visible?
        @element.displayed?
      end
    
      #
      # return true if an element exists
      #
      def exists?
        nil != @element
      end

      #
      # return the text for the element
      #
      def text
        @element.text
      end
      
    end
  end
end