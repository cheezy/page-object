module PageObject
  module Platforms
    module SeleniumWebDriver
      class SurrogateSeleniumElement
        attr_accessor :identifier, :type, :tag, :other, :platform
        
        def exists?
          attempt_to_find_element unless @element
          @element ? (not @element.element.nil?) : false
        end
        
        def visible?
          attempt_to_find_element unless @element
          @element ? @element.element.displayed? : false
        end

        def nil?
          attempt_to_find_element unless @element
          @element ? @element.element.nil? : true
        end

        def displayed?
          attempt_to_find_element unless @element
          @element ? @element.element.displayed? : false
        end

        def method_missing(meth, *args)
          return @element.send(meth, *args) if @element
          $stderr.puts "You are calling #{meth} on an element that does not yet exist."
          raise Selenium::WebDriver::Error::NoSuchElementError
        end

        private

        def attempt_to_find_element
          @element = platform.send(:find_selenium_element, identifier, type, tag, other) unless @element
          @element = nil if @element.element.instance_of?(::PageObject::Platforms::SeleniumWebDriver::SurrogateSeleniumElement)
        end
      end
    end
  end
end
