require 'spec_helper'

class TestPageObject
  include PageObject
end

describe PageObject do
  context "when created with a watir-webdriver browser" do
    before(:each) do
      @browser = Watir::Browser.new :firefox
    end
    
    after(:each) do
      @browser.close
    end
    
    it "should include the WatirPageObject module" do
      page_object = TestPageObject.new(@browser)
      page_object.should be_kind_of PageObject::WatirPageObject
    end
  end

end
