require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Label do
  let(:label) { PageObject::Elements::Label }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :text, :index, :xpath].each do |t|
        identifier = label.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :text, :index, :xpath].each do |t|
        key, value = label.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end

    describe "interface" do
      it "should register with tag :label" do
        expect(::PageObject::Elements.element_class_for(:label)).to eql ::PageObject::Elements::Label
      end
    end
  end
end

