module PageObject
  module Platforms
    module Selenium

      def self.create_page_object(browser)
        require 'page-object/selenium_page_object'
        return PageObject::SeleniumPageObject.new(browser)
      end

      def self.is_for?(browser)
        browser.is_a? Object::Selenium::WebDriver::Driver
      end
    end
  end
end
PageObject::Platforms.register(:selenium, PageObject::Platforms::Selenium)