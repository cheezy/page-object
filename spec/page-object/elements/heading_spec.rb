require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Heading do
  let(:heading) { PageObject::Elements::Heading }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        identifier = heading.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        key, value = heading.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end

  describe "interface" do
    it "should register with tag :h1" do
      ::PageObject::Elements.element_class_for(:h1).should == ::PageObject::Elements::Heading
    end

    it "should register with tag :h2" do
      ::PageObject::Elements.element_class_for(:h2).should == ::PageObject::Elements::Heading
    end

    it "should register with tag :h3" do
      ::PageObject::Elements.element_class_for(:h3).should == ::PageObject::Elements::Heading
    end

    it "should register with tag :h4" do
      ::PageObject::Elements.element_class_for(:h4).should == ::PageObject::Elements::Heading
    end

    it "should register with tag :h5" do
      ::PageObject::Elements.element_class_for(:h5).should == ::PageObject::Elements::Heading
    end

    it "should register with tag :h6" do
      ::PageObject::Elements.element_class_for(:h6).should == ::PageObject::Elements::Heading
    end
  end
end
