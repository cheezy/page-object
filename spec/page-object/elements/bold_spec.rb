require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Bold do
  let(:bold) { PageObject::Elements::Bold }

  describe "interface" do

    it "should register with tag :b" do
      expect(::PageObject::Elements.element_class_for(:b)).to eql ::PageObject::Elements::Bold
    end
  end
end
