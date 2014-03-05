require 'spec_helper'

class PageObjectTestPageObject
  include PageObject

  text_field(:tf, :id => 'id')
  text_area(:ta, :id => 'id')
  select_list(:sl, :id => 'id')
  file_field(:ff, :id => 'id')
  checkbox(:cb, :id => 'id')
  radio_button(:rb, :id => 'id')
  radio_button_group(:rbg, :id => 'id')
end

describe PageObject::PagePopulator  do
  let(:browser) { mock_watir_browser }
  let(:page_object) { PageObjectTestPageObject.new(browser) }

  it "should set a value in a text field" do
    page_object.should_receive(:tf=).with('value')
    page_object.stub(:is_enabled?).and_return(true)
    page_object.populate_page_with('tf' => 'value')
  end

  it "should not set a value in a text field if it is not found on the page" do
    browser.should_not_receive(:text_field)
    page_object.populate_page_with('coffee' => 'value')
  end

  it "should not populate a text field when it is disabled" do
    page_object.should_not_receive(:tf=)
    page_object.should_receive(:tf_element).twice.and_return(browser)
    browser.should_receive(:enabled?).and_return(false)
    browser.should_receive(:tag_name).and_return('input')
    page_object.populate_page_with('tf' => true)
  end

  it "should not populate a text field when it is not visible" do
    page_object.should_not_receive(:tf=)
    page_object.should_receive(:tf_element).twice.and_return(browser)
    browser.should_receive(:enabled?).and_return(true)
    browser.should_receive(:visible?).and_return(false)
    browser.should_receive(:tag_name).and_return('input')
    page_object.populate_page_with('tf' => true)
  end

  it "should set a value in a text area" do
    page_object.should_receive(:ta=).with('value')
    page_object.should_receive(:ta_element).and_return(browser)
    browser.should_receive(:tag_name).and_return('textarea')
    page_object.populate_page_with('ta' => 'value')
  end

  it "should set a value in a select list" do
    page_object.should_receive(:sl=).with('value')
    page_object.stub(:is_enabled?).and_return(true)
    page_object.populate_page_with('sl' => 'value')
  end

  it "should set a value in a file field" do
    page_object.should_receive(:ff=).with('value')
    page_object.stub(:is_enabled?).and_return(true)
    page_object.populate_page_with('ff' => 'value')
  end

  it "should check a checkbox to true is specified" do
    page_object.should_receive(:check_cb)
    page_object.stub(:is_enabled?).and_return(true)
    page_object.populate_page_with('cb' => true)
  end

  it "should uncheck a checkbox to false is specified" do
    page_object.should_receive(:uncheck_cb)
    page_object.stub(:is_enabled?).and_return(true)
    page_object.populate_page_with('cb' => false)
  end

  it "should select a radio button when true is specified" do
    page_object.should_receive(:select_rb)
    page_object.stub(:is_enabled?).and_return(true)
    page_object.populate_page_with('rb' => true)
  end

  it "should clear a radio button when false is specified" do
    page_object.should_receive(:clear_rb)
    page_object.stub(:is_enabled?).and_return(true)
    page_object.populate_page_with('rb' => false)
  end

  it "should select the correct element from a radio button group" do
    page_object.should_receive(:select_rbg).with('blah')
    page_object.populate_page_with('rbg' => 'blah')
  end

  it "should not populate a checkbox if it is disabled" do
    page_object.should_not_receive(:check_cb)
    page_object.should_receive(:cb_element).twice.and_return(browser)
    browser.should_receive(:enabled?).and_return(false)
    browser.should_receive(:tag_name).and_return('input')
    page_object.populate_page_with('cb' => true)
  end

  it "should not populate a checkbox if it is not visible" do
    page_object.should_not_receive(:check_cb)
    page_object.should_receive(:cb_element).twice.and_return(browser)
    browser.should_receive(:enabled?).and_return(true)
    browser.should_receive(:visible?).and_return(false)
    browser.should_receive(:tag_name).and_return('input')
    page_object.populate_page_with('cb' => true)
  end

  it "should not populate a radio button when it is disabled" do
    page_object.should_not_receive(:select_rb)
    page_object.should_receive(:rb_element).twice.and_return(browser)
    browser.should_receive(:enabled?).and_return(false)
    browser.should_receive(:tag_name).and_return('input')
    page_object.populate_page_with('rb' => true)
  end

  it "should not populate a radio button when it is not visible" do
    page_object.should_not_receive(:select_rb)
    page_object.should_receive(:rb_element).twice.and_return(browser)
    browser.should_receive(:enabled?).and_return(true)
    browser.should_receive(:visible?).and_return(false)
    browser.should_receive(:tag_name).and_return('input')
    page_object.populate_page_with('rb' => true)
  end
end
