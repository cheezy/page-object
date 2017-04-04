require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Label do
  let(:label) { PageObject::Elements::Label }

  describe "interface" do
    it "should register with tag :label" do
      expect(::PageObject::Elements.element_class_for(:label)).to eql ::PageObject::Elements::Label
    end
  end
end

