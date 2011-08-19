require 'spec_helper'

class ElementLocatorsTestPageObject
  include PageObject
end


describe PageObject::ElementLocators do
  let(:watir_browser) { mock_watir_browser }
  let(:watir_page_object) { ElementLocatorsTestPageObject.new(watir_browser) }
  
  it "should find a button element" do
    watir_browser.should_receive(:button).with(:id => 'blah').and_return(watir_browser)
    element = watir_page_object.button_element(:id => 'blah')
    element.should be_instance_of PageObject::Elements::Button
  end
  
  it "should find a text field element" do
    watir_browser.should_receive(:text_field).with(:id => 'blah').and_return(watir_browser)
    element = watir_page_object.text_field_element(:id => 'blah')
    element.should be_instance_of PageObject::Elements::TextField
  end
  
  it "should find a hidden field element" do
    watir_browser.should_receive(:hidden).with(:id => 'blah').and_return(watir_browser)
    element = watir_page_object.hidden_field_element(:id => 'blah')
    element.should be_instance_of PageObject::Elements::HiddenField
  end
  
  it "should find a text area element" do
    watir_browser.should_receive(:textarea).with(:id => 'blah').and_return(watir_browser)
    element = watir_page_object.text_area_element(:id => 'blah')
    element.should be_instance_of PageObject::Elements::TextArea
  end
  
  it "should find a select list element" do
    watir_browser.should_receive(:select_list).with(:id => 'blah').and_return(watir_browser)
    element = watir_page_object.select_list_element(:id => 'blah')
    element.should be_instance_of PageObject::Elements::SelectList
  end
end