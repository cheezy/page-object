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
        watir_table = PageObject::Elements::Table.new(table_element, :platform => :watir)
        table_element.stub(:[]).with(1)
        watir_table[1].should be_instance_of PageObject::Elements::TableRow
      end
      
      it "should return the number of rows" do
        watir_table = PageObject::Elements::Table.new(table_element, :platform => :watir)
        table_element.stub(:wd).and_return(table_element)
        table_element.should_receive(:find_elements).with(:xpath, "//child::tr").and_return(table_element)
        table_element.should_receive(:size).and_return(2)
        watir_table.rows.should == 2
      end

      it "should iterate over the table rows" do
        watir_table = PageObject::Elements::Table.new(table_element, :platform => :watir)
        watir_table.should_receive(:rows).and_return(2)
        count = 0
        watir_table.each { |e| count += 1 }
        count.should == 2
      end    
    end    

    context "for selenium" do
      it "should return a table row when indexed" do
        selenium_table = PageObject::Elements::Table.new(table_element, :platform => :selenium)
        table_element.should_receive(:find_element).with(:xpath, ".//tr[2]")
        selenium_table[1].should be_instance_of PageObject::Elements::TableRow
      end
      
      it "should return the number of rows" do
        selenium_table = PageObject::Elements::Table.new(table_element, :platform => :selenium)
        table_element.should_receive(:find_elements).with(:xpath, "//child::tr").and_return(table_element)
        table_element.should_receive(:size).and_return(2)
        selenium_table.rows.should == 2
      end
      
      it "should iterate over the table rows" do
        selenium_table = PageObject::Elements::Table.new(table_element, :platform => :selenium)
        selenium_table.should_receive(:rows).and_return(2)
        count = 0
        selenium_table.each { |e| count += 1 }
        count.should == 2
      end
    end    
  end
end