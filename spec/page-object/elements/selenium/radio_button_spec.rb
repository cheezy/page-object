require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::RadioButton do
  let(:radiobutton) { PageObject::Elements::RadioButton }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :value, :xpath].each do |t|
        identifier = radiobutton.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end
    it "should map selenium types to same" do
      [:class, :id, :name, :xpath, :value, :index].each do |t|
        key, value = radiobutton.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end

  describe "interface" do

    it "should register as type :radio" do
      ::PageObject::Elements.element_class_for(:input, :radio).should == ::PageObject::Elements::RadioButton
    end
    
    context "for selenium" do
      let(:selenium_rb) { double('radio_button') }
      let(:radio_button) { PageObject::Elements::RadioButton.new(selenium_rb, :platform => :selenium_webdriver) }

      it "should select" do
        selenium_rb.should_receive(:click)
        selenium_rb.should_receive(:selected?).and_return(false)
        radio_button.select
      end
      
      it "should clear" do
        selenium_rb.should_receive(:click)
        selenium_rb.should_receive(:selected?).and_return(true)
        radio_button.clear
      end
      
      it "should know if it is selected" do
        selenium_rb.should_receive(:selected?).and_return(true)
        radio_button.should be_selected
      end
    end
  end
end
