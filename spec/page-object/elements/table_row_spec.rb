require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::TableRow do
  describe "interface" do
    context "for watir" do
      let(:driver) { double('driver') }
      let(:table_cell) { double('table_cell') }
      let(:table_row) { PageObject::Elements::TableRow.new(driver, :platform => :watir) }
      
      it "should return a table cell when indexed" do
        driver.should_receive(:[]).with(1).and_return(table_cell)
        table_row[1].should be_instance_of PageObject::Elements::TableCell
      end
    end
  end
end