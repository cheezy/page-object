module PageObject
  module Platforms
    module WatirWebDriver

      module TextArea
        
        #
        # Set the value of the TextArea
        #
        def value=(new_value)
          element.set(new_value)
        end
        
        #
        # Clear the TextArea
        #
        def clear
          element.wd.clear
        end
      end
    end
  end
end
