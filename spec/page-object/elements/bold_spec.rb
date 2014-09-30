require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Bold do
  let(:bold) { PageObject::Elements::Bold }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        identifier = bold.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        key, value = bold.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end

  describe "interface" do

    it "should register with tag :b" do
      ::PageObject::Elements.element_class_for(:b).should == ::PageObject::Elements::Bold
    end
  end
end
