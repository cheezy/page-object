module PageObject
  module Platforms
    module SeleniumImage
      
      #
      # Return the width of the image.
      #
      def width
        dimension = @element.size
        dimension.width
      end
      
      #
      # Return the height of the image
      #
      def height
        dimension = @element.size
        dimension.height
      end
    end
  end
end