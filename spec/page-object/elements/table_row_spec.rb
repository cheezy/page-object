require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::TableRow do
  let(:table_cell) { double('table_cell') }
  let(:table_row_driver) { double('table_row_driver') }

  describe "interface" do
    context "for watir" do
      it "should return a table cell when indexed" do
        table_row = PageObject::Elements::TableRow.new(table_row_driver, :platform => :watir)    
        table_row_driver.should_receive(:[]).with(1).and_return(table_cell)
        table_row[1].should be_instance_of PageObject::Elements::TableCell
      end

      it "should return the number of columns" do
        table_row = PageObject::Elements::TableRow.new(table_row_driver, :platform => :watir)
        table_row_driver.should_receive(:wd).and_return(table_row_driver)
        table_row_driver.should_receive(:find_elements).with(:xpath, ".//child::td|th").and_return(table_row_driver)
        table_row_driver.should_receive(:size).and_return(3)
        table_row.columns.should == 3
      end
    end    

    context "for selenium" do
      it "should return a table cell when indexed" do
        table_row = PageObject::Elements::TableRow.new(table_row_driver, :platform => :selenium)
        table_row_driver.should_receive(:find_elements).with(:xpath, ".//child::td|th").and_return(table_cell)
        table_cell.should_receive(:[]).and_return(table_cell)
        table_row[0].should be_instance_of PageObject::Elements::TableCell
      end
      
      it "should retrun the number of columns" do
        table_row = PageObject::Elements::TableRow.new(table_row_driver, :platform => :selenium)
        table_row_driver.should_receive(:find_elements).with(:xpath, ".//child::td|th").and_return(table_row_driver)
        table_row_driver.should_receive(:size).and_return(3)
        table_row.columns.should == 3
      end
    end
  end
end