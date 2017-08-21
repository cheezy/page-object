module PageObject
  module Platforms
    module Watir

      def self.create_page_object(browser)
        browser = selenium_browser(browser) unless watir?(browser)
        return Watir::PageObject.new(browser)
      end

      def self.is_for?(browser)
        require 'watir'
        watir?(browser) || selenium?(browser)
      end

      def self.browser_for root
        return watir_browser(root) if watir?(root)
        return selenium_browser(root) if selenium?(root)
        nil
      end

      def self.root_element_for root
        Elements::Element.new(root) if is_for?(root)
      end

      def self.browser_root_for browser
        browser.element
      end

      private

      def self.watir_browser(root)
        return root if root.is_a?(::Watir::Browser)
        root.browser
      end

      def self.selenium_browser(root)
        return ::Watir::Browser.new(root) if root.is_a?(::Selenium::WebDriver::Driver)
        ::Watir::Browser.new(Selenium::WebDriver::Driver.new(root.send(:bridge)))
      end

      def self.watir?(browser)
        browser.is_a?(::Watir::Browser) || browser.is_a?(::Watir::HTMLElement)
      end

      def self.selenium?(browser)
        browser.is_a?(::Selenium::WebDriver::Driver) || browser.is_a?(::Selenium::WebDriver::Element)
      end
    end
  end
end
