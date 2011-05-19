require 'spec_helper'

class TestPageObject
  include PageObject

  checkbox(:active, {:id => 'is_active_id'})
end

describe "check_box accessors" do
  let(:watir_browser) { mock_watir_browser }
  let(:selenium_browser) { mock_selenium_browser }
  let(:watir_page_object) { TestPageObject.new(watir_browser) }
  let(:selenium_page_object) { TestPageObject.new(selenium_browser) }

  context "when called on a page object" do
    it "should generate accessor methods" do
      watir_page_object.should respond_to :check_active
      watir_page_object.should respond_to :uncheck_active
      watir_page_object.should respond_to :active_checked?
    end
  end

  context "Watir implementation" do
    it "should check a check box element" do
      watir_browser.should_receive(:checkbox).and_return(watir_browser)
      watir_browser.should_receive(:set)
      watir_page_object.check_active
    end

    it "should clear a check box element" do
      watir_browser.should_receive(:checkbox).and_return(watir_browser)
      watir_browser.should_receive(:clear)
      watir_page_object.uncheck_active
    end

    it "should know if a check box element is selected" do
      watir_browser.should_receive(:checkbox).and_return(watir_browser)
      watir_browser.should_receive(:set?).and_return(true)
      watir_page_object.active_checked?.should be_true
    end
  end

  context "Selenium implementation" do
    it "should check a check box element" do
      selenium_browser.should_receive(:find_element).twice.and_return(selenium_browser)
      selenium_browser.should_receive(:selected?).and_return(false)
      selenium_browser.should_receive(:toggle)
      selenium_page_object.check_active
    end
    
    it "should clear a check box element" do
      selenium_browser.should_receive(:find_element).twice.and_return(selenium_browser)
      selenium_browser.should_receive(:selected?).and_return(true)
      selenium_browser.should_receive(:toggle)
      selenium_page_object.uncheck_active
    end
    
    it "should know if a check box element is selected" do
      selenium_browser.should_receive(:find_element).and_return(selenium_browser)
      selenium_browser.should_receive(:selected?).and_return(true)
      selenium_page_object.active_checked?.should be_true
    end
  end
end
