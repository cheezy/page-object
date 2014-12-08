require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Div do
  let(:div) { PageObject::Elements::Div }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :text, :index, :xpath, :name, :title, :css].each do |t|
        identifier = div.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :text, :index, :name, :xpath, :title, :css].each do |t|
        key, value = div.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end

    describe "interface" do
      it "should register with tag :div" do
        expect(::PageObject::Elements.element_class_for(:div)).to eql ::PageObject::Elements::Div
      end
    end
  end
end
