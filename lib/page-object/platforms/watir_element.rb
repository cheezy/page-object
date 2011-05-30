
module PageObject
  module Platforms
    module WatirElement
      
      #
      # return true if an element is visible
      #
      def visible?
        @element.present?
      end

      #
      # return true if an element exists
      #
      def exists?
        @element.exists?
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