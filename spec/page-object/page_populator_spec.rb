require 'spec_helper'

class PageObjectTestPageObject
  include PageObject

  text_field(:tf, :id => 'id')
  text_area(:ta, :id => 'id')
  select_list(:sl, :id => 'id')
  checkbox(:cb, :id => 'id')
  radio_button(:rb, :id => 'id')
end

describe PageObject::PagePopulator  do
  let(:browser) { mock_watir_browser }
  let(:page_object) { PageObjectTestPageObject.new(browser) }

  it "should set a value in a text field" do
    page_object.should_receive(:tf=).with('value')
    page_object.populate_page_with('tf' => 'value')
  end

  it "should not set a value if it is not found on the page" do
    browser.should_not_receive(:text_field)
    page_object.populate_page_with('coffee' => 'value')
  end

  it "should set a value in a text area" do
    page_object.should_receive(:ta=).with('value')
    page_object.populate_page_with('ta' => 'value')
  end

  it "should set a value in a select list" do
    page_object.should_receive(:sa=).with('value')
    page_object.populate_page_with('sa' => 'value')
  end

  it "should check a checkbox to true is specified" do
    page_object.should_receive(:check_cb)
    page_object.populate_page_with('cb' => true)
  end

  it "should uncheck a checkbox to false is specified" do
    page_object.should_receive(:uncheck_cb)
    page_object.populate_page_with('cb' => false)
  end

  it "should select a radio button when true is specified" do
    page_object.should_receive(:select_rb)
    page_object.populate_page_with('rb' => true)
  end

  it "should clear a radio button when false is specified" do
    page_object.should_receive(:clear_rb)
    page_object.populate_page_with('rb' => false)
  end
end
