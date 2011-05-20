require 'spec_helper'
require 'page-object/elements'

describe RadioButton do
  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        identifier = RadioButton.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end
    it "should map selenium types to same" do
      [:class, :id, :name, :xpath].each do |t|
        key, value = RadioButton.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end
end
