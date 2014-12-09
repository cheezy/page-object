require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::TextField do

  describe "when mapping how to find an element" do
    let(:textfield) { PageObject::Elements::TextField }

    it "should map watir types to same" do
      [:class, :id, :index, :name, :title, :xpath, :text, :label].each do |t|
        identifier = textfield.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :name, :title, :xpath, :index, :text, :label].each do |t|
        key, value = textfield.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end
  end
  
  describe "interface" do
    let(:text_field_element) { double('text_field') }
    let(:selenium_text_field) { PageObject::Elements::TextField.new(text_field_element, :platform => :selenium_webdriver) }

    it "should register with type :text" do
      expect(::PageObject::Elements.element_class_for(:input, :text)).to eql ::PageObject::Elements::TextField
    end

    it "should register with type :password" do
      expect(::PageObject::Elements.element_class_for(:input, :password)).to eql ::PageObject::Elements::TextField
    end

    it "should append text" do
      expect(text_field_element).to receive(:send_keys).with('abc')
      selenium_text_field.append('abc')
    end
    
    context "for selenium" do
      it "should set its' value" do
        expect(text_field_element).to receive(:clear)
        expect(text_field_element).to receive(:send_keys).with('Joseph')
        selenium_text_field.value = 'Joseph'
      end
    end
  end
end
