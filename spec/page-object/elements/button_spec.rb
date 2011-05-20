require 'spec_helper'

class TestPageObject
  include PageObject

  button(:click_me, {:id => 'click_me'})
end

describe "button accessors" do
  let(:watir_browser) { mock_watir_browser }
  let(:selenium_browser) { mock_selenium_browser }
  let(:watir_page_object) { TestPageObject.new(watir_browser) }
  let(:selenium_page_object) { TestPageObject.new(selenium_browser) }
  
  context "when called on a page object" do
    it "should generate accessor methods" do
      watir_page_object.should respond_to :click_me
      watir_page_object.should respond_to :click_me=
    end
  end
  
#  context "Watir implementation" do
#    it "should get the current item from a select list" do
#      watir_browser.stub_chain(:select_list, :value).and_return("OH")
#      watir_page_object.state.should == "OH"
#    end
#
#    it "should set the current item of a select list" do
#      watir_browser.stub(:select_list).and_return watir_browser
#      watir_browser.stub(:select).with("OH")
#      watir_page_object.state = "OH"
#    end
#  end
#
#  context "Selenium implementation" do
#    it "should should get the current item from a select list" do
#      selenium_browser.stub_chain(:find_element, :attribute).and_return("OH")
#      selenium_page_object.state.should == "OH"
#    end
#
#    it "should set the current item of a select list" do
#      selenium_browser.stub_chain(:find_element, :send_keys).with("OH")
#      selenium_page_object.state = "OH"
#    end
#  end
end