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
    expect(page_object).to receive(:tf=).with('value')
    allow(page_object).to receive(:is_enabled?).and_return(true)
    page_object.populate_page_with('tf' => 'value')
  end

  it "should not set a value in a text field if it is not found on the page" do
    expect(browser).not_to receive(:text_field)
    page_object.populate_page_with('coffee' => 'value')
  end

  it "should not populate a text field when it is disabled" do
    expect(page_object).not_to receive(:tf=)
    expect(page_object).to receive(:tf_element).twice.and_return(browser)
    expect(browser).to receive(:enabled?).and_return(false)
    expect(browser).to receive(:tag_name).and_return('input')
    page_object.populate_page_with('tf' => true)
  end

  it "should not populate a text field when it is not visible" do
    expect(page_object).not_to receive(:tf=)
    expect(page_object).to receive(:tf_element).twice.and_return(browser)
    expect(browser).to receive(:enabled?).and_return(true)
    expect(browser).to receive(:visible?).and_return(false)
    expect(browser).to receive(:tag_name).and_return('input')
    page_object.populate_page_with('tf' => true)
  end

  it "should set a value in a text area" do
    expect(page_object).to receive(:ta=).with('value')
    expect(page_object).to receive(:ta_element).and_return(browser)
    expect(browser).to receive(:tag_name).and_return('textarea')
    page_object.populate_page_with('ta' => 'value')
  end

  it "should set a value in a select list" do
    expect(page_object).to receive(:sl=).with('value')
    allow(page_object).to receive(:is_enabled?).and_return(true)
    page_object.populate_page_with('sl' => 'value')
  end

  it "should set a value in a file field" do
    expect(page_object).to receive(:ff=).with('value')
    allow(page_object).to receive(:is_enabled?).and_return(true)
    page_object.populate_page_with('ff' => 'value')
  end

  it "should check a checkbox to true is specified" do
    expect(page_object).to receive(:check_cb)
    allow(page_object).to receive(:is_enabled?).and_return(true)
    page_object.populate_page_with('cb' => true)
  end

  it "should uncheck a checkbox to false is specified" do
    expect(page_object).to receive(:uncheck_cb)
    allow(page_object).to receive(:is_enabled?).and_return(true)
    page_object.populate_page_with('cb' => false)
  end

  it "should select a radio button when true is specified" do
    expect(page_object).to receive(:select_rb)
    allow(page_object).to receive(:is_enabled?).and_return(true)
    page_object.populate_page_with('rb' => true)
  end

  it "should select the correct element from a radio button group" do
    expect(page_object).to receive(:select_rbg).with('blah')
    page_object.populate_page_with('rbg' => 'blah')
  end

  it "should not populate a checkbox if it is disabled" do
    expect(page_object).not_to receive(:check_cb)
    expect(page_object).to receive(:cb_element).twice.and_return(browser)
    expect(browser).to receive(:enabled?).and_return(false)
    expect(browser).to receive(:tag_name).and_return('input')
    page_object.populate_page_with('cb' => true)
  end

  it "should not populate a checkbox if it is not visible" do
    expect(page_object).not_to receive(:check_cb)
    expect(page_object).to receive(:cb_element).twice.and_return(browser)
    expect(browser).to receive(:enabled?).and_return(true)
    expect(browser).to receive(:visible?).and_return(false)
    expect(browser).to receive(:tag_name).and_return('input')
    page_object.populate_page_with('cb' => true)
  end

  it "should not populate a radio button when it is disabled" do
    expect(page_object).not_to receive(:select_rb)
    expect(page_object).to receive(:rb_element).twice.and_return(browser)
    expect(browser).to receive(:enabled?).and_return(false)
    expect(browser).to receive(:tag_name).and_return('input')
    page_object.populate_page_with('rb' => true)
  end

  it "should not populate a radio button when it is not visible" do
    expect(page_object).not_to receive(:select_rb)
    expect(page_object).to receive(:rb_element).twice.and_return(browser)
    expect(browser).to receive(:enabled?).and_return(true)
    expect(browser).to receive(:visible?).and_return(false)
    expect(browser).to receive(:tag_name).and_return('input')
    page_object.populate_page_with('rb' => true)
  end
end
