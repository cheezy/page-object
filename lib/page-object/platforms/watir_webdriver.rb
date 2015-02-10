module PageObject
  module Platforms
    module WatirWebDriver
      
      def self.create_page_object(browser)
        require 'page-object/platforms/watir_webdriver/page_object'
        return WatirWebDriver::PageObject.new(browser)
      end

      def self.is_for?(browser)
        require 'watir-webdriver'
        res=browser.is_a?(::Watir::Browser)

        unless res && Gem::Specification.find_all_by_name('watir-nokogiri').any?
          require 'watir-nokogiri'
          res= browser.is_a?(::WatirNokogiri::Document)
        end

        res
      end
    end
  end
end

PageObject::Platforms.register(:watir_webdriver, PageObject::Platforms::WatirWebDriver)
