require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::TextArea do
  let(:textarea) { PageObject::Elements::TextArea }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :tag_name, :xpath].each do |t|
        identifier = textarea.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to watir" do
      identifier = textarea.watir_identifier_for :css => 'value'
      identifier.keys.first.should == :tag_name
    end

    it "should map selenium types to same" do
      [:class, :css, :id, :name, :xpath, :index].each do |t|
        key, value = textarea.selenium_identifier_for t => 'value'
        key.should == t
      end
    end

    it "should map watir types to selenium" do
      key, value = textarea.selenium_identifier_for :tag_name => 'value'
      key.should == :css
    end
  end
  
  describe "interface" do

    it "should register with tag_name :textarea" do
      ::PageObject::Elements.element_class_for(:textarea).should == ::PageObject::Elements::TextArea
    end
    
    context "for Selenium" do
      it "should set its' value" do
        text_area_element = double('text_area')
        text_area = PageObject::Elements::TextArea.new(text_area_element, :platform => :selenium_webdriver)
        text_area_element.should_receive(:clear)
        text_area_element.should_receive(:send_keys).with('Joseph')
        text_area.value = 'Joseph'
      end
    end
  end
end
