require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Table do
  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :xpath].each do |t|
        identifier = PageObject::Elements::Table.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :name, :xpath].each do |t|
        key, value = PageObject::Elements::Table.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end
  
  describe "interface" do
    let(:table_element) { double('table_element') }
    
    before(:each) do
      table_element.stub(:[])
      table_element.stub(:find_element)
    end
    
    context "for watir" do
      it "should return a table row when indexed" do
        wat_table = PageObject::Elements::Table.new(table_element, :platform => :watir)
        table_element.stub(:[]).with(1)
        wat_table[1].should be_instance_of PageObject::Elements::TableRow
      end
    end    

    context "for selenium" do
      it "should return a table row when indexed" do
        sel_table = PageObject::Elements::Table.new(table_element, :platform => :selenium)
        table_element.stub(:find_element).with(:xpath, ".//tr[2]")
        sel_table[1].should be_instance_of PageObject::Elements::TableRow
      end
    end    
  end
end