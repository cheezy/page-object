require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::FileField do

  describe "interface" do
    let(:filefield) { double('file_field') }

    it "should register as type :file" do
      expect(::PageObject::Elements.element_class_for(:input, :file)).to eql ::PageObject::Elements::FileField
    end
  end
end
