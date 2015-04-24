module PageObject
  module Platforms
    module SeleniumWebDriver
      module Button
        #
        # Override PageObject::PLatforms::SeleniumElement#text
        # to get #text from buttons and #attribute('value') from inputs
        #
        def text
          element.tag_name == 'button' ? element.text : element.attribute('value')
        end
      end
    end
  end
end