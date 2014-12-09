require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::CheckBox do
  let(:checkbox) { PageObject::Elements::CheckBox }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath, :value].each do |t|
        identifier = checkbox.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end
    it "should map selenium types to same" do
      [:class, :id, :name, :xpath, :index, :value].each do |t|
        key, value = checkbox.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end
  end
  
  describe "interface" do
    let(:check_box) { double('check_box') }
    let(:selenium_cb) { PageObject::Elements::CheckBox.new(check_box, :platform => :selenium_webdriver) }

    it "should register with type :checkbox" do
      expect(::PageObject::Elements.element_class_for(:input, :checkbox)).to eql ::PageObject::Elements::CheckBox
    end
    
    context "for selenium" do
      it "should check" do
        expect(check_box).to receive(:click)
        expect(check_box).to receive(:selected?).and_return(false)
        selenium_cb.check
      end

      it "should uncheck" do
        expect(check_box).to receive(:click)
        expect(check_box).to receive(:selected?).and_return(true)
        selenium_cb.uncheck
      end
      
      it "should know if it is checked" do
        expect(check_box).to receive(:selected?).and_return(true)
        expect(selenium_cb).to be_checked
      end
    end
  end
end
