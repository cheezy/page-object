module PageObject
  module Platforms
    module SeleniumWebDriver
      module CheckBox

        #
        # check the checkbox
        #
        def check
          element.click unless element.selected?
        end

        #
        # uncheck the checkbox
        #
        def uncheck
          element.click if element.selected?
        end

        #
        # return true if it is checked
        #
        def checked?
          element.selected?
        end
      end
    end
  end
end
