require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::OrderedList do
  let(:ol) { PageObject::Elements::OrderedList }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :xpath].each do |t|
        identifier = ol.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        key, value = ol.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end
  end

  describe "interface" do
    let(:ol_element) { double('ol_element') }

    it "should register as tag_name :ol" do
      expect(::PageObject::Elements.element_class_for(:ol)).to eql ::PageObject::Elements::OrderedList
    end

    context "for watir" do
      it "should return a list item when indexed" do
        ol = PageObject::Elements::OrderedList.new(ol_element, :platform => :watir_webdriver)
        expect(ol_element).to receive(:find_elements).
                               and_return([ol_element, ol_element])
        ol[1]
      end

      it "should know how many list items it contains" do
        ol = PageObject::Elements::OrderedList.new(ol_element, :platform => :watir_webdriver)
        expect(ol_element).to receive(:find_elements).and_return([ol_element])
        expect(ol.items).to eql 1
      end

      it "should iterate over the list items" do
        ol = PageObject::Elements::OrderedList.new(ol_element, :platform => :watir_webdriver)
        expect(ol).to receive(:items).and_return(5)
        allow(ol).to receive(:[])
        count = 0
        ol.each { |item| count += 1 }
        expect(count).to eql 5
      end
    end

    context "for selenium" do
      it "should return a list item when indexed" do
        ol = PageObject::Elements::OrderedList.new(ol_element, :platform => :selenium_webdriver)
        expect(ol_element).to receive(:find_elements).
                               and_return([ol_element, ol_element])
        ol[1]
      end

      it "should know how many list items it contains" do
        ol = PageObject::Elements::OrderedList.new(ol_element, :platform => :selenium_webdriver)
        expect(ol_element).to receive(:find_elements).and_return([ol_element])
        expect(ol.items).to eql 1
      end

      it "should iterate over the list items" do
        ol = PageObject::Elements::OrderedList.new(ol_element, :platform => :selenium_webdriver)
        expect(ol).to receive(:items).and_return(5)
        allow(ol).to receive(:[])
        count = 0
        ol.each { |item| count += 1 }
        expect(count).to eql 5
      end
    end
  end
end
