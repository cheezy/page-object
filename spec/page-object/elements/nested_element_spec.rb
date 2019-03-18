require 'spec_helper'
require 'page-object/elements'


describe "Element with nested elements" do
  before(:each) do
    @watir_driver = instance_double('Watir::Element')
    @watir_element = PageObject::Elements::Element.new(@watir_driver)
  end

  it "should find nested links" do
    expect(@watir_driver).to receive(:link).with(:id => 'blah')
    @watir_element.link_element(:id => 'blah')
  end

  it "should find nested buttons" do
    expect(@watir_driver).to receive(:button).with(:id => 'blah')
    @watir_element.button_element(:id => 'blah')
  end

  it "should find nested text fields" do
    expect(@watir_driver).to receive(:text_field).with(:id => 'blah')
    @watir_element.text_field_element(:id => 'blah')
  end

  it "should find nested hidden fields" do
    expect(@watir_driver).to receive(:hidden)
    @watir_element.hidden_field_element
  end

  it "should find nested text areas" do
    expect(@watir_driver).to receive(:textarea)
    @watir_element.text_area_element
  end

  it "should find a nested select list" do
    expect(@watir_driver).to receive(:select_list)
    @watir_element.select_list_element
  end

  it "should find a nested checkbox" do
    expect(@watir_driver).to receive(:checkbox)
    @watir_element.checkbox_element
  end

  it "should find a nested radio button" do
    expect(@watir_driver).to receive(:radio)
    @watir_element.radio_button_element
  end

  it "should find a nested div" do
    expect(@watir_driver).to receive(:div)
    @watir_element.div_element
  end

  it "should find a nested span" do
    expect(@watir_driver).to receive(:span)
    @watir_element.span_element
  end

  it "should find a nested table" do
    expect(@watir_driver).to receive(:table)
    @watir_element.table_element
  end

  it "should find a nested cell" do
    expect(@watir_driver).to receive(:td)
    @watir_element.cell_element
  end

  it "should find a nested image" do
    expect(@watir_driver).to receive(:image)
    @watir_element.image_element
  end

  it "should find a nested form" do
    expect(@watir_driver).to receive(:form)
    @watir_element.form_element
  end

  it "should find a nested ordered list" do
    expect(@watir_driver).to receive(:ol)
    @watir_element.ordered_list_element
  end

  it "should find a nested unordered list" do
    expect(@watir_driver).to receive(:ul)
    @watir_element.unordered_list_element
  end

  it "should find a nested list item" do
    expect(@watir_driver).to receive(:li)
    @watir_element.list_item_element
  end

  it "should find a nested h1" do
    expect(@watir_driver).to receive(:h1)
    @watir_element.h1_element
  end

  it "should find a nested h2" do
    expect(@watir_driver).to receive(:h2)
    @watir_element.h2_element
  end

  it "should find a nested h3" do
    expect(@watir_driver).to receive(:h3)
    @watir_element.h3_element
  end

  it "should find a nested h4" do
    expect(@watir_driver).to receive(:h4)
    @watir_element.h4_element
  end

  it "should find a nested h5" do
    expect(@watir_driver).to receive(:h5)
    @watir_element.h5_element
  end

  it "should find a nested h6" do
    expect(@watir_driver).to receive(:h6)
    @watir_element.h6_element
  end
end
