module PageObject
  module Platforms
    module WatirImage
      
      #
      # Return the width of the image.
      #
      def width
        @element.width
      end

      #
      # Return the height of the image
      #
      def height
        @element.height
      end
    end
  end
end
