require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Italic do
  let(:italic) { PageObject::Elements::Italic }

  describe "interface" do

    it "should register with tag :i" do
      expect(::PageObject::Elements.element_class_for(:i)).to eql ::PageObject::Elements::Italic
    end
  end
end
