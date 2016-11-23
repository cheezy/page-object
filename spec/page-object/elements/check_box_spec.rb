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
  end
  
  describe "interface" do
    let(:check_box) { double('check_box') }
    let(:selenium_cb) { PageObject::Elements::CheckBox.new(check_box, :platform => :selenium_webdriver) }

    it "should register with type :checkbox" do
      expect(::PageObject::Elements.element_class_for(:input, :checkbox)).to eql ::PageObject::Elements::CheckBox
    end
  end
end
