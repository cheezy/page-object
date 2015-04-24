module PageObject
  module Platforms
    module SeleniumWebDriver

      def self.create_page_object(browser)
        SeleniumWebDriver::PageObject.new(browser)
      end

      def self.is_for?(browser)
        require 'selenium-webdriver'
        browser.is_a?(::Selenium::WebDriver::Driver) || browser.is_a?(::Selenium::WebDriver::Element)
      end

      def self.browser_for root
        return root if root.is_a?(::Selenium::WebDriver::Driver)
        Selenium::WebDriver::Driver.new(root.send(:bridge))
      end

      def self.root_element_for root
        Elements::Element.new root, platform: :selenium_webdriver if root.is_a?(::Selenium::WebDriver::Element)
      end

      def self.browser_root_for browser
        browser.find_element(tag_name: 'html')
      end
    end
  end
end

PageObject::Platforms.register(:selenium_webdriver, PageObject::Platforms::SeleniumWebDriver)