require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Paragraph do
  let(:paragraph) { PageObject::Elements::Paragraph }

  describe "interface" do
    it "should register with type :checkbox" do
      expect(::PageObject::Elements.element_class_for(:p)).to eql ::PageObject::Elements::Paragraph
    end
  end
end
