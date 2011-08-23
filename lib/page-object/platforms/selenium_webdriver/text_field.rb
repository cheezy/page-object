module PageObject
  module Platforms
    module SeleniumWebDriver

      module TextField
        
        #
        # Set the value of the TextField
        #
        def value=(new_value)
          element.clear
          element.send_keys(new_value)
        end
      end
    end
  end
end
