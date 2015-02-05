module PageObject
  module Platforms
    module WatirWebDriver

      def self.create_page_object(browser)
        require 'page-object/platforms/watir_webdriver/page_object'
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
        root = root.element unless root.is_a? ::Watir::HTMLElement
        Elements::Element.new root, :platform => :watir_webdriver
      end
    end
  end
end

PageObject::Platforms.register(:watir_webdriver, PageObject::Platforms::WatirWebDriver)
