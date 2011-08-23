module PageObject
  module Platforms
    module WatirWebDriver
      
      def self.create_page_object(browser)
        require 'page-object/platforms/watir_webdriver/page_object'
        return WatirWebDriver::PageObject.new(browser)
      end

      def self.is_for?(browser)
        browser.is_a?(Object::Watir::Browser)
      end
    end
  end
end

PageObject::Platforms.register(:watir_webdriver, PageObject::Platforms::WatirWebDriver)
