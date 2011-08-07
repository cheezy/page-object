module PageObject
  module Platforms
    module Selenium

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
