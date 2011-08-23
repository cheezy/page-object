module PageObject
  module Platforms
    module WatirWebDriver
      module CheckBox
        
        #
        # check the checkbox
        #
        def check
          element.set
        end

        #
        # uncheck the checkbox
        #
        def uncheck
          element.clear
        end

        #
        # return true if checkbox is checked
        #
        def checked?
          element.set?
        end
      end
    end
  end
end
