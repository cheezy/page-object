module PageObject
  module Platforms
    module WatirWebDriver

      def self.create_page_object(browser)
        return WatirWebDriver::PageObject.new(browser)
      end

      def self.is_for?(browser)
        require 'watir-webdriver'
        browser.is_a?(::Watir::Browser) || browser.is_a?(::Watir::HTMLElement)
      end

      def self.browser_for root
        return root if root.is_a?(::Watir::Browser)
        root.browser
      end

      def self.root_element_for root
        Elements::Element.new root, :platform => :watir_webdriver if root.is_a? ::Watir::HTMLElement
      end

      def self.browser_root_for browser
        browser.element
      end
    end
  end
end

PageObject::Platforms.register(:watir_webdriver, PageObject::Platforms::WatirWebDriver)
