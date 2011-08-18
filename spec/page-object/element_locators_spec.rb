require 'spec_helper'

class ElementLocatorsTestPageObject
  include PageObject
end


describe PageObject::ElementLocators do
  let(:watir_browser) { mock_watir_browser }
  let(:selenium_browser) { mock_selenium_browser }
  let(:watir_page_object) { ElementLocatorsTestPageObject.new(watir_browser) }
  let(:selenium_page_object) { ElementLocatorsTestPageObject.new(selenium_browser) }
  
  it "should find a button element" do
    watir_browser.should_receive(:button).with(:id => 'blah').and_return(watir_browser)
    element = watir_page_object.button(:id => 'blah')
    element.should be_instance_of PageObject::Elements::Button
  end
end