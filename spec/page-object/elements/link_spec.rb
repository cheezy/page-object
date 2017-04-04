require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Link do
  let(:link) { PageObject::Elements::Link }

  describe "interface" do
    let(:link_element) { double('link_element') }

    it "should register with tag :a" do
      expect(::PageObject::Elements.element_class_for(:a)).to eql ::PageObject::Elements::Link
    end
  end
end
