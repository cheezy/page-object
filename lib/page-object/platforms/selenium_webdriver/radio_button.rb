module PageObject
  module Platforms
    module SeleniumWebDriver
      module RadioButton

        #
        # select the radiobutton
        #
        def select
          element.click unless selected?
        end

        #
        # return if it is selected
        #
        def selected?
          element.selected?
        end
      end
    end
  end
end
