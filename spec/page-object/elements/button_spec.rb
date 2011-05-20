require 'spec_helper'
require 'page-object/elements'

describe Button do
  context "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        identifier = Button.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end
  end

end