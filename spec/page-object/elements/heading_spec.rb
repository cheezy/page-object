require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Heading do
  let(:heading) { PageObject::Elements::Heading }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        identifier = heading.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        key, value = heading.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end
  end

  describe "interface" do
    it "should register with tag :h1" do
      expect(::PageObject::Elements.element_class_for(:h1)).to eql ::PageObject::Elements::Heading
    end

    it "should register with tag :h2" do
      expect(::PageObject::Elements.element_class_for(:h2)).to eql ::PageObject::Elements::Heading
    end

    it "should register with tag :h3" do
      expect(::PageObject::Elements.element_class_for(:h3)).to eql ::PageObject::Elements::Heading
    end

    it "should register with tag :h4" do
      expect(::PageObject::Elements.element_class_for(:h4)).to eql ::PageObject::Elements::Heading
    end

    it "should register with tag :h5" do
      expect(::PageObject::Elements.element_class_for(:h5)).to eql ::PageObject::Elements::Heading
    end

    it "should register with tag :h6" do
      expect(::PageObject::Elements.element_class_for(:h6)).to eql ::PageObject::Elements::Heading
    end
  end
end
