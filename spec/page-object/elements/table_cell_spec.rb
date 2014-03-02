require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::TableCell do

  context "interface" do
    it "should register with tag_name :td" do
      ::PageObject::Elements.element_class_for(:td).should == ::PageObject::Elements::TableCell
    end

    it "should register with tag_name :th" do
      ::PageObject::Elements.element_class_for(:th).should == ::PageObject::Elements::TableCell
    end

    it "should always be enabled" do
      table_cell_element = double('table_cell_element')
      table_cell = PageObject::Elements::TableCell.new(table_cell_element, :platform => :selenium_webdriver)
      table_cell.enabled?.should be true
    end
  end
end
