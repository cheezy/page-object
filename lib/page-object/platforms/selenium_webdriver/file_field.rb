module PageObject
  module Platforms
    module SeleniumWebDriver

      module FileField
        
        #
        # Set the value of the FileField
        #
        def value=(new_value)
          element.send_keys(new_value)
        end
      end
    end
  end
end
