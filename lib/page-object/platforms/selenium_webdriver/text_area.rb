module PageObject
  module Platforms
    module SeleniumWebDriver

      module TextArea
        
        #
        # Set the value of the TextArea
        #
        def value=(new_value)
          element.clear
          element.send_keys(new_value)
        end
      end
    end
  end
end
