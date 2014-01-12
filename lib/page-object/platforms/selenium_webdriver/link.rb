module PageObject
  module Platforms
    module SeleniumWebDriver
      module Link
        #
        # Override PageObject::PLatforms::SeleniumElement#value because
        # #value is not available on links in Selenium.
        #
        def value
          raise "value not available on link element with Selenium"
        end

        #
        # return the href for the link
        #
        def href
          attribute('href')
        end
      end
    end
  end

end
