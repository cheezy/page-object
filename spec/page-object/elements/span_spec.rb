require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Span do
  let(:span) { PageObject::Elements::Span }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :text, :title, :xpath].each do |t|
        identifier = span.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :text, :title, :xpath].each do |t|
        key, value = span.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end
  end

  it "should register with tag_name :span" do
    expect(::PageObject::Elements.element_class_for(:span)).to eql ::PageObject::Elements::Span
  end
end
