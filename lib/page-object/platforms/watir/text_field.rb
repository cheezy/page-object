module PageObject
  module Platforms
    module WatirWebDriver

      module TextField
        
        #
        # Set the value of the TextField
        #
        def value=(new_value)
          element.set(new_value)
        end
      end
    end
  end
end
