module PageObject
  module Platforms
    module SeleniumWebDriver

      def self.create_page_object(browser)
        require 'page-object/platforms/selenium_webdriver/page_object'
        SeleniumWebDriver::PageObject.new(browser)
      end

      def self.is_for?(browser)
        require 'selenium-webdriver'
        browser.is_a? ::Selenium::WebDriver::Driver
      end
    end
  end
end

PageObject::Platforms.register(:selenium_webdriver, PageObject::Platforms::SeleniumWebDriver)