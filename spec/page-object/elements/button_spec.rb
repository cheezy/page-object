require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Button do
  let(:button) { PageObject::Elements::Button }

  describe "interface" do
    let(:button_element) { double('button_element') }

    it "should register with type :submit" do
      expect(::PageObject::Elements.element_class_for(:input, :submit)).to eql ::PageObject::Elements::Button
    end

    it "should register with type :image" do
      expect(::PageObject::Elements.element_class_for(:input, :image)).to eql ::PageObject::Elements::Button
    end

    it "should register with type :button" do
      expect(::PageObject::Elements.element_class_for(:input, :button)).to eql ::PageObject::Elements::Button
    end

    it "should register with type :reset" do
      expect(::PageObject::Elements.element_class_for(:input, :reset)).to eql ::PageObject::Elements::Button
    end
  end
end
