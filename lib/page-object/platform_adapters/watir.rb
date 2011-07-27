
module PageObject
  module Adapters
    module Watir
      def self.create_page_object(browser)
        require 'page-object/watir_page_object'
        PageObject::WatirPageObject.new(browser)
      end
      def self.is_for?(browser)
        browser.is_a?(Object::Watir::Browser)
      end
    end
  end
end

PageObject::Adapters.register(:watir, PageObject::Adapters::Watir)
