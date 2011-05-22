require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Table do
  describe "when mapping how to find an element" do
    let(:table) { PageObject::Elements::Table }

    it "should map watir types to same" do
      [:class, :id, :index, :xpath].each do |t|
        identifier = table.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :name, :xpath].each do |t|
        key, value = table.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end
end