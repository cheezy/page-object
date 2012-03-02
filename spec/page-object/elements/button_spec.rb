require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Button do
  let(:button) { PageObject::Elements::Button }

  context "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :value, :xpath, :src, :alt, :css].each do |t|
        identifier = button.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :value, :xpath, :src, :alt, :css].each do |t|
        key, value = button.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end

  describe "interface" do
    let(:button_element) { double('button_element') }

    it "should register with type :submit" do
      ::PageObject::Elements.element_class_for(:input, :submit).should == ::PageObject::Elements::Button
    end

    it "should register with type :image" do
      ::PageObject::Elements.element_class_for(:input, :image).should == ::PageObject::Elements::Button
    end

    it "should register with type :button" do
      ::PageObject::Elements.element_class_for(:input, :button).should == ::PageObject::Elements::Button
    end

    it "should retisger with type :reset" do
      ::PageObject::Elements.element_class_for(:input, :reset).should == ::PageObject::Elements::Button
    end

    context "for selenium" do
      it "should return error when asked for its' text" do
        button = PageObject::Elements::Button.new(button_element, :platform => :selenium_webdriver)
        lambda { button.text }.should raise_error
      end
    end
  end

end
