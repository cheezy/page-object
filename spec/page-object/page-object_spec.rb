require 'spec_helper'

class TestPageObject
  include PageObject
end

describe PageObject do

  context "when created with a watir-webdriver browser" do
    it "should include the WatirPageObject module" do
      browser = Watir::Browser.new :firefox
      page_object = TestPageObject.new(browser)
      page_object.driver.should be_kind_of PageObject::WatirPageObject
      browser.close
    end
  end

  context "when created with a selenium browser" do
    it "should include the SeleniumPageObject module" do
      browser = Selenium::WebDriver.for :firefox
      page_object = TestPageObject.new(browser)
      page_object.driver.should be_kind_of PageObject::SeleniumPageObject
      browser.close
    end
  end
  
  context "when created with an object we do not understand" do
    it "should throw an error" do
      expect {
        TestPageObject.new("blah")
      }.to raise_error
    end
  end

  describe "page level functionality" do
    context "when using WatirPageObject" do
      let(:watir_browser) { mock_watir_browser }
      
      it "should display the page text" do
        watir_browser.should_receive(:text).and_return("browser text")
        page = TestPageObject.new(watir_browser)
        page.text.should == "browser text"
      end

      it "should be able to navigate to a page" do
        watir_browser.should_receive(:goto).with("cheezyworld.com")
        page = TestPageObject.new(watir_browser)
        page.navigate_to("cheezyworld.com")
      end

    end

    context "when using SeleniumPageObject" do
      let(:selenium_browser) { mock_selenium_browser }
      
      it "should display the page text" do
        selenium_browser.stub_chain(:find_element, :text).and_return("browser text")
        page = TestPageObject.new(selenium_browser)
        page.text.should == "browser text"
      end
      
      it "should be able to navigate to a page" do
        selenium_browser.stub_chain(:navigate, :to).with('cheezyworld.com')
        page = TestPageObject.new(selenium_browser)
        page.navigate_to('cheezyworld.com')
      end

    end
  end
end
