require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Option do

  describe "interface" do
    it "should register as tag_name :option" do
      expect(::PageObject::Elements.element_class_for(:option)).to eql ::PageObject::Elements::Option
    end
  end

  describe "interacting with the option" do
    let(:wd) { double('') }
    let(:native) { double(wd: wd) }
    let(:element) { PageObject::Elements::Option.new(native) }

    it 'should know if it is selected' do
      expect(native).to receive(:selected?).and_return true
      expect(element.selected?).to be true
    end
  end
end
