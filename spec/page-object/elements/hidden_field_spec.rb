require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::HiddenField do
  let(:hiddenfield) { PageObject::Elements::HiddenField }

  describe "interface" do
    it "should register with type :hidden" do
      expect(::PageObject::Elements.element_class_for(:input, :hidden)).to eql ::PageObject::Elements::HiddenField
    end
  end
end
