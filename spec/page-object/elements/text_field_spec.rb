require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::TextField do

  describe "when mapping how to find an element" do
    let(:textfield) { PageObject::Elements::TextField }

    it "should map watir types to same" do
      [:class, :id, :index, :name, :title, :xpath, :text, :label].each do |t|
        identifier = textfield.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :name, :title, :xpath, :index, :text, :label].each do |t|
        key, value = textfield.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end
  
  describe "interface" do
    let(:text_field_element) { double('text_field') }
    let(:selenium_text_field) { PageObject::Elements::TextField.new(text_field_element, :platform => :selenium_webdriver) }

    it "should register with type :text" do
      ::PageObject::Elements.element_class_for(:input, :text).should == ::PageObject::Elements::TextField
    end

    it "should register with type :password" do
      ::PageObject::Elements.element_class_for(:input, :password).should == ::PageObject::Elements::TextField
    end

    it "should append text" do
      text_field_element.should_receive(:send_keys).with('abc')
      selenium_text_field.append('abc')
    end
    
    context "for selenium" do
      it "should set its' value" do
        text_field_element.should_receive(:clear)
        text_field_element.should_receive(:send_keys).with('Joseph')
        selenium_text_field.value = 'Joseph'
      end
    end
  end
end
