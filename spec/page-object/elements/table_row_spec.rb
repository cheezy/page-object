require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::TableRow do
  let(:table_cell) { double('table_cell') }
  let(:table_row_driver) { double('table_row_driver') }

  describe "interface" do
    context "for selenium" do
      it "should return a table cell when indexed" do
        @sel_table_row = PageObject::Elements::TableRow.new(table_row_driver, :platform => :selenium)        
        table_row_driver.should_receive(:find_element).with(:xpath, "./th|td[1]").and_return(table_cell)
        @sel_table_row[0].should be_instance_of PageObject::Elements::TableCell
      end
    end

    context "for watir" do
      it "should return a table cell when indexed" do
        @wat_table_row = PageObject::Elements::TableRow.new(table_row_driver, :platform => :watir)    
        table_row_driver.should_receive(:[]).with(1).and_return(table_cell)
        @wat_table_row[1].should be_instance_of PageObject::Elements::TableCell
      end
    end    
  end
end