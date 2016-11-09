require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Image do
  let(:image) { PageObject::Elements::Image }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath, :alt, :src].each do |t|
        identifier = image.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :xpath, :alt, :src].each do |t|
        key, value = image.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end
  end

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
        image = PageObject::Elements::Image.new(image_element, :platform => :watir)
        expect(image_element).to receive(:width).and_return(100)
        expect(image.width).to eql 100
      end

      it "should know the images height" do
        image = PageObject::Elements::Image.new(image_element, :platform => :watir)
        expect(image_element).to receive(:height).and_return(120)
        expect(image.height).to eql 120
      end
    end

    context "for selenium" do
      it "should know the images width" do
        dim = double('dimension')
        image = PageObject::Elements::Image.new(image_element, :platform => :selenium_webdriver)
        expect(image_element).to receive(:size).and_return(dim)
        expect(dim).to receive(:width).and_return(100)
        expect(image.width).to eql 100
      end

      it "should know the images height" do
        dim = double('dimension')
        image = PageObject::Elements::Image.new(image_element, :platform => :selenium_webdriver)
        expect(image_element).to receive(:size).and_return(dim)
        expect(dim).to receive(:height).and_return(120)
        expect(image.height).to eql 120
      end
    end
  end
end
