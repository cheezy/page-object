require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::TextArea do
  let(:textarea) { PageObject::Elements::TextArea }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        identifier = textarea.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end
  end
  
  describe "interface" do
    it "should register with tag_name :textarea" do
      expect(::PageObject::Elements.element_class_for(:textarea)).to eql ::PageObject::Elements::TextArea
    end
  end
end
