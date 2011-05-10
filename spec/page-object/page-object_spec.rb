require 'spec_helper'

class TestPageObject
  include PageObject
end

describe PageObject do
  context "when created with a watir-webdriver browser" do
    it "should include the WatirPageObject module" do
      @browser = Watir::Browser.new :firefox
      page_object = TestPageObject.new(@browser)
      page_object.should be_kind_of PageObject::WatirPageObject
      @browser.close
    end
  end

  context "when created with a selenium browser" do
    it "should include the SeleniumPageObject module" do
      @browser = Selenium::WebDriver.for :firefox
      page_object = TestPageObject.new(@browser)
      page_object.should be_kind_of PageObject::SeleniumPageObject
      @browser.close
    end
  end
  
  context "when created with an object we do not understand" do
    it "should throw an error" do
      expect {
        TestPageObject.new("blah")
      }.to raise_error
    end
  end
end
