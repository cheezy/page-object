module PageObject
  module Platforms
    module Watir
      def self.create_page_object(browser)
        require 'page-object/platforms/watir/page_object'
        PageObject::WatirPageObject.new(browser)
      end

      def self.is_for?(browser)
        browser.is_a?(Object::Watir::Browser)
      end
    end
  end
end

PageObject::Platforms.register(:watir, PageObject::Platforms::Watir)
