module PageObject
  module Platforms
    module Watir

      module TextArea
        
        #
        # Set the value of the TextArea
        #
        def value=(new_value)
          element.set(new_value)
        end
      end
    end
  end
end
