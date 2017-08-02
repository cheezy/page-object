require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Image do
  let(:image) { PageObject::Elements::Image }

  describe "interface" do
    let(:image_element) { double('image_element') }

    before(:each) do
      allow(image_element).to receive(:size).and_return(image_element)
    end

    it "should register with tag_name :img" do
      expect(::PageObject::Elements.element_class_for(:img)).to eql ::PageObject::Elements::Image
    end

    context "for watir" do
      it "should know the images width" do
        image = PageObject::Elements::Image.new(image_element)
        expect(image_element).to receive(:width).and_return(100)
        expect(image.width).to eql 100
      end

      it "should know the images height" do
        image = PageObject::Elements::Image.new(image_element)
        expect(image_element).to receive(:height).and_return(120)
        expect(image.height).to eql 120
      end
    end
  end
end
