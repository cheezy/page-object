module PageObject
  module Platforms
    module WatirWebDriver
      module RadioButton

        #
        # select the radiobutton
        #
        def select
          element.set
        end

        #
        # return if it is selected
        #
        def selected?
          element.set?
        end
      end
    end
  end
end
