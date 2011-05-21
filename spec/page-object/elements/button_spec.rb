require 'spec_helper'
require 'page-object/elements'

describe PageObject::Button do
  context "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        identifier = PageObject::Button.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :name, :xpath].each do |t|
        key, value = PageObject::Button.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end

end