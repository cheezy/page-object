require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::RadioButton do
  let(:radiobutton) { PageObject::Elements::RadioButton }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :value, :xpath].each do |t|
        identifier = radiobutton.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end
    it "should map selenium types to same" do
      [:class, :id, :name, :xpath, :value, :index].each do |t|
        key, value = radiobutton.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end
  end

  describe "interface" do

    it "should register as type :radio" do
      expect(::PageObject::Elements.element_class_for(:input, :radio)).to eql ::PageObject::Elements::RadioButton
    end
    
    context "for selenium" do
      let(:selenium_rb) { double('radio_button') }
      let(:radio_button) { PageObject::Elements::RadioButton.new(selenium_rb, :platform => :selenium_webdriver) }

      it "should select" do
        expect(selenium_rb).to receive(:click)
        expect(selenium_rb).to receive(:selected?).and_return(false)
        radio_button.select
      end
      
      it "should know if it is selected" do
        expect(selenium_rb).to receive(:selected?).and_return(true)
        expect(radio_button).to be_selected
      end
    end
  end
end
