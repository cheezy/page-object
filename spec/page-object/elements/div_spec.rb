require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Div do
  let(:div) { PageObject::Elements::Div }

  describe "interface" do
    it "should register with tag :div" do
      expect(::PageObject::Elements.element_class_for(:div)).to eql ::PageObject::Elements::Div
    end
  end
end
