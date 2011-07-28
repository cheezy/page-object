require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Div do
  let(:div) { PageObject::Elements::Div }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :xpath].each do |t|
        identifier = div.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        key, value = div.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end
end