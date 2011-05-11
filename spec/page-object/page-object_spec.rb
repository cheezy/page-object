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
      def mock_watir_browser
        watir_browser = double('watir')
        watir_browser.should_receive(:is_a?).with(Watir::Browser).and_return(true)
        watir_browser
      end

      it "should display the page text" do
        watir_browser = mock_watir_browser
        watir_browser.should_receive(:text).and_return("browser text")
        page_object = TestPageObject.new(watir_browser)
        page_object.text.should == "browser text"
      end
    end

    context "when using SeleniumPageObject" do
      def mock_selenium_browser
        selenium_browser = double('selenium')
        selenium_browser.should_receive(:is_a?).with(Watir::Browser).and_return(false)
        selenium_browser.should_receive(:is_a?).with(Selenium::WebDriver::Driver).and_return(true)
        selenium_browser
      end
  
      it "should display the page text" do
        selenium_browser = mock_selenium_browser
        selenium_browser.should_receive(:body_text).and_return("browser text")
        page = TestPageObject.new(selenium_browser)
        page.text.should == "browser text"
      end

    end
  end
end
