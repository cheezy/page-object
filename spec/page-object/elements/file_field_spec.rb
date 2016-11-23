require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::FileField do

  describe "when mapping how to find an element" do
    let(:filefield) { PageObject::Elements::FileField }

    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath, :title].each do |t|
        identifier = filefield.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end
  end

  describe "interface" do
    let(:filefield) { double('file_field') }

    it "should register as type :file" do
      expect(::PageObject::Elements.element_class_for(:input, :file)).to eql ::PageObject::Elements::FileField
    end
  end
end
