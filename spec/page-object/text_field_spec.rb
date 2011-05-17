require 'spec_helper'

class TestPageObject
  include PageObject

  text_field(:first_name, {:id => 'first_name'})
end

describe "text_field accessors" do
  let(:watir_browser) { mock_watir_browser }
  let(:selenium_browser) { mock_selenium_browser }
  let(:watir_page_object) { TestPageObject.new(watir_browser) }
  let(:selenium_page_object) { TestPageObject.new(selenium_browser) }

  context "when called on a page object" do
    it "should generate accessor methods" do
      watir_page_object.should respond_to(:first_name)
      watir_page_object.should respond_to(:first_name=)
    end
  end

  context "Watir implementation" do
    it "should get the text from the text field element" do
      watir_browser.stub_chain(:text_field, :value).and_return('Kim')
      watir_page_object.first_name.should == 'Kim'
    end
    
    it "should set some text on a text field element" do
      watir_browser.stub_chain(:text_field, :set).with('Kim')
      watir_page_object.first_name = 'Kim'
    end
  end

  context "Selenium implementation" do
    it "should get the text from the text field element" do
      selenium_browser.stub_chain(:find_element, :value).and_return('Katie')
      selenium_page_object.first_name.should == 'Katie'
    end

    it "should set some text on a text field element" do
      selenium_browser.stub_chain(:find_element, :send_keys)
      selenium_page_object.first_name = 'Katie'
    end
  end
end
