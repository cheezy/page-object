require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::TableRow do
  let(:table_cell) { double('table_cell') }
  let(:table_row_driver) { double('table_row_driver') }
  let(:table_row) { PageObject::Elements::TableRow.new(table_row_driver) }

  describe "interface" do

    it "should register with tag_name :tr" do
      expect(::PageObject::Elements.element_class_for(:tr)).to eql ::PageObject::Elements::TableRow
    end
    
    context "for watir" do
      before(:each) do
        allow(table_row_driver).to receive(:find_elements).and_return(table_row_driver)
        allow(table_row_driver).to receive(:cells).and_return(Array.new(2, Watir::TableCell))
      end

      it "should return a table cell when indexed" do
        expect(table_row[1]).to be_instance_of PageObject::Elements::TableCell
      end

      it "should return the number of columns" do
        expect(table_row.columns).to eql 2
      end

      it "should iterate over the table columns" do
        count = 0
        table_row.each { count += 1 }
        expect(count).to eql 2
      end
    end
  end
end
