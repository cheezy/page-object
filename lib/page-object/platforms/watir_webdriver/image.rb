module PageObject
  module Platforms
    module WatirWebDriver
      module Image

        #
        # Return the width of the image.
        #
        def width
          element.width
        end

        #
        # Return the height of the image
        #
        def height
          element.height
        end
      end
    end
  end
end
