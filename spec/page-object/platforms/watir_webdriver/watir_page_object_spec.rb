require 'spec_helper'

describe PageObject::Platforms::WatirWebDriver do
  describe "create page object" do
    let(:browser) { double('browser') }
    let(:subject) { PageObject::Platforms::WatirWebDriver.create_page_object(browser) }
    
    it "should create a WatirPageObject" do
      subject.should be_kind_of PageObject::Platforms::WatirWebDriver::PageObject
    end
    
    it "should give the watir page object the browser" do
      subject.browser.should be browser
    end
  end
  
  describe "is for?" do
    it "should be true when the browser is Watir::Browser" do
      browser = mock_watir_browser()
      PageObject::Platforms::WatirWebDriver.is_for?(browser).should be true
    end
    
    it "should be false at any other point" do
      browser = 'asdf'
      PageObject::Platforms::WatirWebDriver.is_for?('asdf').should be false
    end
  end
end

