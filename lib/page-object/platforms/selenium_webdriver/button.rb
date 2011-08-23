module PageObject
  module Platforms
    module SeleniumWebDriver
      module Button
        #
        # Override PageObject::PLatforms::SeleniumElement#text because
        # #text does not reliabably return a value in Selenium
        #
        def text
          raise "text is not available on button element in Selenium"
        end
      end
    end
  end
end