require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::TextArea do
  let(:textarea) { PageObject::Elements::TextArea }

  describe "interface" do
    it "should register with tag_name :textarea" do
      expect(::PageObject::Elements.element_class_for(:textarea)).to eql ::PageObject::Elements::TextArea
    end
  end
end
