require 'spec_helper'


describe PageObject::Platforms::SeleniumWebDriver do

  it "should be registered as an adapter" do
    PageObject::Platforms.get[:selenium_webdriver].should be PageObject::Platforms::SeleniumWebDriver

  end
  describe 'create page object' do
    let(:browser) { double('browser') }
    let(:subject) { PageObject::Platforms::SeleniumWebDriver.create_page_object(browser) }
    
    it "should create a SeleniumPageObject" do
      subject.should be_kind_of PageObject::Platforms::SeleniumWebDriver::PageObject
    end
  end
  
  describe "is for?" do
    it "should be true when the browser is a selenium driver" do
      browser = mock_selenium_browser()
      PageObject::Platforms::SeleniumWebDriver.is_for?(browser).should == true
    end
    
    it "should be false when the browser is anything else" do
      PageObject::Platforms::SeleniumWebDriver.is_for?("asdf").should == false
    end
  end
end