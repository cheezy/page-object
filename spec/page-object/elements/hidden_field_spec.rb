require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::HiddenField do
  let(:hiddenfield) { PageObject::Elements::HiddenField }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :text, :xpath, :value].each do |t|
        identifier = hiddenfield.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :name, :xpath, :index, :value].each do |t|
        key, value = hiddenfield.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end
  end

  describe "interface" do
    it "should register with type :hidden" do
      expect(::PageObject::Elements.element_class_for(:input, :hidden)).to eql ::PageObject::Elements::HiddenField
    end
  end
end
