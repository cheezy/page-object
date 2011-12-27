require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::CheckBox do
  let(:checkbox) { PageObject::Elements::CheckBox }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath, :value].each do |t|
        identifier = checkbox.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end
    it "should map selenium types to same" do
      [:class, :id, :name, :xpath, :index, :value].each do |t|
        key, value = checkbox.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end
  
  describe "interface" do
    let(:check_box) { double('check_box') }
    let(:selenium_cb) { PageObject::Elements::CheckBox.new(check_box, :platform => :selenium_webdriver) }

    it "should register with type :checkbox" do
      ::PageObject::Elements.element_class_for(:input, :checkbox).should == ::PageObject::Elements::CheckBox
    end
    
    context "for selenium" do
      it "should check" do
        check_box.should_receive(:click)
        check_box.should_receive(:selected?).and_return(false)
        selenium_cb.check
      end

      it "should uncheck" do
        check_box.should_receive(:click)
        check_box.should_receive(:selected?).and_return(true)
        selenium_cb.uncheck
      end
      
      it "should know if it is checked" do
        check_box.should_receive(:selected?).and_return(true)
        selenium_cb.should be_checked
      end
    end
  end
end
