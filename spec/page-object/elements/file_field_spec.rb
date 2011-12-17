require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::FileField do

  describe "when mapping how to find an element" do
    let(:filefield) { PageObject::Elements::FileField }

    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath, :title].each do |t|
        identifier = filefield.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :xpath, :title].each do |t|
        key, value = filefield.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end
end
