module PageObject
  module Platforms
    module SeleniumImage

      #
      # Return the width of the image.
      #
      def width
        dimension.width
      end

      #
      # Return the height of the image
      #
      def height
        dimension.height
      end

      private

      def dimension
        @element.size
      end
    end
  end
end