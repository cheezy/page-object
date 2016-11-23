require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Link do
  let(:link) { PageObject::Elements::Link }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :href, :id, :index, :name, :text, :xpath, :css, :title].each do |t|
        identifier = link.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :link, :link_text, :name, :xpath, :index, :css, :title].each do |t|
        key, value = link.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end
  end

  describe "interface" do
    let(:link_element) { double('link_element') }

    it "should register with tag :a" do
      expect(::PageObject::Elements.element_class_for(:a)).to eql ::PageObject::Elements::Link
    end
  end
end
