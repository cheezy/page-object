require 'spec_helper'

class TestPageObject
  include PageObject

  link(:google_search, {:text => 'Google Search'})
end

describe "link" do
  let(:watir_browser) { mock_watir_browser }
  let(:selenium_browser) { mock_selenium_browser }
  let(:watir_page_object) { TestPageObject.new(watir_browser) }
  let(:selenium_page_object) { TestPageObject.new(selenium_browser) }

  context "when called on a page object" do
    it "should generate accessor methods" do
      watir_page_object.should respond_to(:google_search)
      watir_page_object.should respond_to(:google_search_no_wait)
    end
  end

  context "Watir implementation" do
    it "should select a link" do
      watir_browser.stub_chain(:link, :click)
      watir_page_object.google_search
    end
    
    it "should select a link and not wait" do
      watir_browser.stub_chain(:link, :click_no_wait)
      watir_page_object.google_search_no_wait
    end
  end

  context "Selenium implementation" do
    it "should select a link" do
      selenium_browser.stub_chain(:find_element, :click)
      selenium_page_object.google_search
    end

    it "should select a link and not wait" do
      selenium_browser.stub_chain(:find_element, :click)
      selenium_page_object.google_search_no_wait
    end
  end

end
