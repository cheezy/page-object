require 'spec_helper'


describe PageObject::Platforms::SeleniumWebDriver do

  it "should be registered as an adapter" do
    expect(PageObject::Platforms.get[:selenium_webdriver]).to be PageObject::Platforms::SeleniumWebDriver
  end
  
  describe 'create page object' do
    let(:browser) { double('browser') }
    let(:subject) { PageObject::Platforms::SeleniumWebDriver.create_page_object(browser) }
    
    it "should create a SeleniumPageObject" do
      expect(subject).to be_kind_of PageObject::Platforms::SeleniumWebDriver::PageObject
    end
  end
  
  describe "is for?" do
    it "should be true when the browser is a selenium driver" do
      browser = mock_selenium_browser()
      expect(PageObject::Platforms::SeleniumWebDriver.is_for?(browser)).to eql true
    end
    
    it "should be false when the browser is anything else" do
      expect(PageObject::Platforms::SeleniumWebDriver.is_for?("asdf")).to eql false
    end
  end
end
