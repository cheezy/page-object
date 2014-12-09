require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::TableRow do
  let(:table_cell) { double('table_cell') }
  let(:table_row_driver) { double('table_row_driver') }

  describe "interface" do

    it "should register with tag_name :tr" do
      expect(::PageObject::Elements.element_class_for(:tr)).to eql ::PageObject::Elements::TableRow
    end
    
    context "for selenium" do
      it "should return a table cell when indexed" do
        table_row = PageObject::Elements::TableRow.new(table_row_driver, :platform => :selenium_webdriver)
        allow(table_row).to receive(:columns).and_return(2)
        expect(table_row_driver).to receive(:find_elements).with(:xpath, ".//child::td|th").and_return(table_cell)
        expect(table_cell).to receive(:[]).and_return(table_cell)
        expect(table_row[0]).to be_instance_of PageObject::Elements::TableCell
      end

      it "should retrun the number of columns" do
        table_row = PageObject::Elements::TableRow.new(table_row_driver, :platform => :selenium_webdriver)
        expect(table_row_driver).to receive(:find_elements).with(:xpath, ".//child::td|th").and_return(table_row_driver)
        expect(table_row_driver).to receive(:size).and_return(3)
        expect(table_row.columns).to eql 3
      end

      it "should iterate over the table columns" do
        table_row = PageObject::Elements::TableRow.new(table_row_driver, :platform => :selenium_webdriver)
        expect(table_row).to receive(:columns).and_return(2)
        allow(table_row).to receive(:[]).and_return(table_row_driver)
        count = 0
        table_row.each { |e| count += 1 }
        expect(count).to eql 2
      end
    end

    context "for watir" do
      before(:each) do
        allow(table_row_driver).to receive(:find_elements).and_return(table_row_driver)
      end

      it "should return a table cell when indexed" do
        table_row = PageObject::Elements::TableRow.new(table_row_driver, :platform => :watir_webdriver)
        allow(table_row).to receive(:columns).and_return(2)
        expect(table_row_driver).to receive(:[]).with(1).and_return(table_cell)
        expect(table_row[1]).to be_instance_of PageObject::Elements::TableCell
      end

      it "should return the number of columns" do
        table_row = PageObject::Elements::TableRow.new(table_row_driver, :platform => :watir_webdriver)
        allow(table_row_driver).to receive(:wd).and_return(table_row_driver)
        expect(table_row_driver).to receive(:find_elements).with(:xpath, ".//child::td|th").and_return(table_row_driver)
        expect(table_row_driver).to receive(:size).and_return(3)
        expect(table_row.columns).to eql 3
      end

      it "should iterate over the table columns" do
        table_row = PageObject::Elements::TableRow.new(table_row_driver, :platform => :watir_webdriver)
        expect(table_row).to receive(:columns).and_return(2)
        allow(table_row).to receive(:[])
        count = 0
        table_row.each { |e| count += 1 }
        expect(count).to eql 2
      end
    end
  end
end
