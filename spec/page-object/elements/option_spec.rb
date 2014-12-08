require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Option do

  describe "interface" do
    it "should register as tag_name :option" do
      expect(::PageObject::Elements.element_class_for(:option)).to eql ::PageObject::Elements::Option
    end
  end
end
