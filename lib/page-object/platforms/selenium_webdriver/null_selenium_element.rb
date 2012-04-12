module PageObject
  module Platforms
    module SeleniumWebDriver
      class NullSeleniumElement
        def exists?
          false
        end
        
        def visible?
          false
        end

        def nil?
          true
        end

        def displayed?
          false
        end

        def method_missing(meth, *args)
          $stderr.puts "You are calling #{meth} on an element that does not yet exist."
          raise Selenium::WebDriver::Error::NoSuchElementError
        end
      end
    end
  end
end
