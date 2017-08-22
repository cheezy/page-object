require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Table do
  describe "interface" do
    let(:table_element) { double('table_element') }

    before(:each) do
      allow(table_element).to receive(:rows).and_return(Array.new(2, Watir::TableRow))
    end

    it "should register with tag_name :table" do
      expect(::PageObject::Elements.element_class_for(:table)).to eql ::PageObject::Elements::Table
    end

    context "for watir" do
      let(:watir_table) { PageObject::Elements::Table.new(table_element) }
      
      it "should return a table row when indexed" do
        expect(watir_table[1]).to be_instance_of PageObject::Elements::TableRow
      end

      it "should return the first row" do
        expect(watir_table.first_row).to be_instance_of PageObject::Elements::TableRow
      end

      it "shoudl return the last row" do
        expect(watir_table.last_row).to be_instance_of PageObject::Elements::TableRow
      end

      it "should return the number of rows" do
        expect(watir_table.rows).to eql 2
      end

      it "should iterate over the table rows" do
        count = 0
        watir_table.each { |e| count += 1 }
        expect(count).to eql 2
      end
    end

  end
end
