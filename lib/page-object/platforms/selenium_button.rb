module PageObject
  module Platforms
    module SeleniumButton
      #
      # Override PageObject::PLatforms::SeleniumElement#text because
      # #text does not reliabably return a value in Selenium
      #
      def text
        raise "value not available on link element with Selenium"
      end
    end
  end
end