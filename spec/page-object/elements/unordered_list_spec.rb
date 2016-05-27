require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::UnorderedList do
  let(:ul) { PageObject::Elements::UnorderedList }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :xpath].each do |t|
        identifier = ul.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        key, value = ul.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end
  end

  describe "interface" do
    let(:ul_element) { double('ul_element') }

    it "should register with tag_name :ul" do
      expect(::PageObject::Elements.element_class_for(:ul)).to eql ::PageObject::Elements::UnorderedList
    end

    context "for watir" do
      it "should return a list item when indexed" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :watir_webdriver)
        allow(ul_element).to receive(:find_elements).and_return(ul_element)
        expect(ul_element).to receive(:[])
        ul[1]
      end

      it "should know how many items it contains" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :watir_webdriver)
        allow(ul_element).to receive(:find_elements).and_return([ul_element])
        expect(ul.items).to eql 1
      end

      it "should know how to iterate over the items" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :watir_webdriver)
        expect(ul).to receive(:items).and_return(5)
        allow(ul).to receive(:[])
        count = 0
        ul.each { |item| count += 1 }
        expect(count).to eql 5
      end
    end

    context "for selenium" do
      it "should return a list item when indexed" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :selenium_webdriver)
        expect(ul_element).to receive(:find_elements).and_return([ul_element, ul_element])
        ul[1]
      end

      it "should know how many items it contains" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :selenium_webdriver)
        expect(ul_element).to receive(:find_elements).and_return([ul_element])
        expect(ul.items).to eql 1
      end

      it "should know how to iterate over the items" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :selenium_webdriver)
        expect(ul).to receive(:items).and_return(5)
        allow(ul).to receive(:[])
        count = 0
        ul.each { |item| count += 1 }
        expect(count).to eql 5
      end
    end
  end
end
