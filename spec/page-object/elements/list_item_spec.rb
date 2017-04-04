require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::ListItem do
  let(:list_item) { PageObject::Elements::ListItem }

  describe "interface" do
    it "should register as tag_name :li" do
      expect(::PageObject::Elements.element_class_for(:li)).to eql ::PageObject::Elements::ListItem
    end

  end
end

