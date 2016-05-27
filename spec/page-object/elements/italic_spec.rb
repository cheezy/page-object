require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Italic do
  let(:italic) { PageObject::Elements::Italic }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        identifier = italic.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        key, value = italic.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end
  end

  describe "interface" do

    it "should register with tag :i" do
      expect(::PageObject::Elements.element_class_for(:i)).to eql ::PageObject::Elements::Italic
    end
  end
end
