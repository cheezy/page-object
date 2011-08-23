module PageObject
  module Platforms
    module WatirWebDriver

      module TextArea
        
        #
        # Set the value of the TextArea
        #
        def value=(new_value)
          element.send_keys(new_value)
        end
      end
    end
  end
end
