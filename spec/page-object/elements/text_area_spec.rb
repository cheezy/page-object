require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::TextArea do
  let(:textarea) { PageObject::Elements::TextArea }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        identifier = textarea.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :name, :xpath, :index].each do |t|
        key, value = textarea.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end
  end
  
  describe "interface" do

    it "should register with tag_name :textarea" do
      expect(::PageObject::Elements.element_class_for(:textarea)).to eql ::PageObject::Elements::TextArea
    end
    
    context "for Selenium" do
      it "should set its' value" do
        text_area_element = double('text_area')
        text_area = PageObject::Elements::TextArea.new(text_area_element, :platform => :selenium_webdriver)
        expect(text_area_element).to receive(:clear)
        expect(text_area_element).to receive(:send_keys).with('Joseph')
        text_area.value = 'Joseph'
      end
    end
  end
end
