require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::UnorderedList do
  let(:ul) { PageObject::Elements::UnorderedList.new(ul_element) }

  describe "interface" do
    let(:ul_element) { double('ul_element') }

    it "should register with tag_name :ul" do
      expect(::PageObject::Elements.element_class_for(:ul)).to eql ::PageObject::Elements::UnorderedList
    end

    context "for watir" do
      before(:each) do
        allow(ul_element).to receive(:children).and_return(Array.new(2, Watir::LI))
      end

      it "should return a list item when indexed" do
        expect(ul[1]).to be_instance_of PageObject::Elements::ListItem
      end

      it "should know how many items it contains" do
        expect(ul.items).to eql 2
      end

      it "should know how to iterate over the items" do
        count = 0
        ul.each { |item| count += 1 }
        expect(count).to eql 2
      end
    end

  end
end
