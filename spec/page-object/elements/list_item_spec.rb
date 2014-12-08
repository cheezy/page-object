require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::ListItem do
  let(:list_item) { PageObject::Elements::ListItem }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :text, :xpath].each do |t|
        identifier = list_item.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :text, :xpath].each do |t|
        key, value = list_item.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end

    describe "interface" do
      it "should register as tag_name :li" do
        expect(::PageObject::Elements.element_class_for(:li)).to eql ::PageObject::Elements::ListItem
      end
    end
  end
end

