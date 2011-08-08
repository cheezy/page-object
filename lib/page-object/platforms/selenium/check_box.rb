module PageObject
  module Platforms
    module Selenium
      module CheckBox

        #
        # check the checkbox
        #
        def check
          element.click unless selected?
        end

        #
        # uncheck the checkbox
        #
        def uncheck
          element.click if selected?
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
