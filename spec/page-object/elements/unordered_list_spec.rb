require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::UnorderedList do
  let(:ul) { PageObject::Elements::UnorderedList }

  describe "interface" do
    let(:ul_element) { double('ul_element') }

    it "should register with tag_name :ul" do
      expect(::PageObject::Elements.element_class_for(:ul)).to eql ::PageObject::Elements::UnorderedList
    end

    context "for watir" do
      it "should return a list item when indexed" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :watir)
        allow(ul_element).to receive(:uls).and_return(ul_element)
        expect(ul_element).to receive(:[])
        ul[1]
      end

      it "should know how many items it contains" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :watir)
        allow(ul_element).to receive(:uls).and_return([ul_element])
        expect(ul.items).to eql 1
      end

      it "should know how to iterate over the items" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :watir)
        expect(ul).to receive(:items).and_return(5)
        allow(ul).to receive(:[])
        count = 0
        ul.each { |item| count += 1 }
        expect(count).to eql 5
      end
    end

  end
end
