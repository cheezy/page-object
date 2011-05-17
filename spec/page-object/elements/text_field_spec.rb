require 'spec_helper'
require 'page-object/elements'

describe TextField do
  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :tag_name, :text, :value, :xpath].each do |t|
        identifier = TextField.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to watir" do
      identifier = TextField.watir_identifier_for :css => 'value'
      identifier.keys.first.should == :tag_name
    end
    
    it "should map selenium types to same" do
      [:class, :css, :id, :name, :xpath].each do |t|
        key, value = TextField.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
    
    it "should map watir types to selenium" do
      key, value = TextField.selenium_identifier_for :tag_name => 'value'
      key.should == :css
    end
  end
end