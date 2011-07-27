
module PageObject
  module Adapters
    module Watir
      def self.create_page_object(browser)
        PageObject::WatirPageObject.new(browser)
      end
    end
  end
end

PageObject::Adapters.register(:watir, PageObject::Adapters::Watir)
