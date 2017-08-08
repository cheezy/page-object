require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::TableCell do

  context "interface" do
    it "should register with tag_name :td" do
      expect(::PageObject::Elements.element_class_for(:td)).to eql ::PageObject::Elements::TableCell
    end

    it "should register with tag_name :th" do
      expect(::PageObject::Elements.element_class_for(:th)).to eql ::PageObject::Elements::TableCell
    end
  end
end
