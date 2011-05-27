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
  
  describe "interface" do
    context "for watir" do
      let(:driver) { double('driver') }
      let(:table_row) { double('table_row') }
      let(:table) { PageObject::Elements::Table.new(driver, :platform => :watir) }
      
      it "should return a table row" do
        driver.should_receive(:[]).with(1).and_return(table_row)
        table[1].should be_instance_of PageObject::Elements::TableRow
      end
    end
  end
end