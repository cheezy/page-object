require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Paragraph do
  let(:paragraph) { PageObject::Elements::Paragraph }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        identifier = paragraph.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end
    it "should map selenium types to same" do
      [:class, :id, :name, :xpath, :index].each do |t|
        key, value = paragraph.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end
  
  describe "interface" do

    it "should register with type :checkbox" do
      ::PageObject::Elements.element_class_for(:p).should == ::PageObject::Elements::Paragraph
    end
  end
end
