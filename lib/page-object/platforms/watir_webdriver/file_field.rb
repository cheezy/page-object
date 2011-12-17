module PageObject
  module Platforms
    module WatirWebDriver

      module FileField
        
        #
        # Set the value of the Fileield
        #
        def value=(new_value)
          element.set(new_value)
        end
      end
    end
  end
end
