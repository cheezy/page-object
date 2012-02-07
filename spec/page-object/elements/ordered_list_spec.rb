require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::OrderedList do
  let(:ol) { PageObject::Elements::OrderedList }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :xpath].each do |t|
        identifier = ol.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        key, value = ol.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end

  describe "interface" do
    let(:ol_element) { double('ol_element') }

    it "should register as tag_name :ol" do
      ::PageObject::Elements.element_class_for(:ol).should == ::PageObject::Elements::OrderedList
    end

    context "for watir" do
      it "should return a list item when indexed" do
        ol = PageObject::Elements::OrderedList.new(ol_element, :platform => :watir_webdriver)
        ol_element.stub(:ols).and_return([ol_element])
        ol_element.stub(:find_elements).and_return(ol_element)
        ol_element.stub(:map).and_return([ol_element])
        ol_element.stub(:parent).and_return(ol_element)
        ol_element.stub(:element).and_return(ol_element)
        ol_element.stub(:==).and_return(true)
        ol[1]
      end

      it "should know how many list items it contains" do
        ol = PageObject::Elements::OrderedList.new(ol_element, :platform => :watir_webdriver)
        ol_element.stub(:ols).and_return([ol_element])
        ol_element.stub(:find_elements).and_return(ol_element)
        ol_element.stub(:map).and_return([ol_element])
        ol_element.stub(:parent).and_return(ol_element)
        ol_element.stub(:element).and_return(ol_element)
        ol_element.stub(:==).and_return(true)
        ol.items.should == 1
      end

      it "should iterate over the list items" do
        ol = PageObject::Elements::OrderedList.new(ol_element, :platform => :watir_webdriver)
        ol.should_receive(:items).and_return(5)
        ol.stub(:[])
        count = 0
        ol.each { |item| count += 1 }
        count.should == 5
      end
    end

    context "for selenium" do
      it "should return a list item when indexed" do
        ol = PageObject::Elements::OrderedList.new(ol_element, :platform => :selenium_webdriver)
        ol_element.should_receive(:find_elements).and_return(ol_element)
        ol_element.should_receive(:map).and_return([ol_element])
        ol_element.should_receive(:parent).and_return(ol_element)
        ol_element.should_receive(:element).and_return(ol_element)
        ol_element.should_receive(:==).and_return(true)
        ol[1]
      end

      it "should know how many list items it contains" do
        ol = PageObject::Elements::OrderedList.new(ol_element, :platform => :selenium_webdriver)
        ol_element.should_receive(:find_elements).and_return(ol_element)
        ol_element.should_receive(:map).and_return([ol_element])
        ol_element.should_receive(:parent).and_return(ol_element)
        ol_element.should_receive(:element).and_return(ol_element)
        ol_element.should_receive(:==).and_return(true)
        ol.items.should == 1
      end

      it "should iterate over the list items" do
        ol = PageObject::Elements::OrderedList.new(ol_element, :platform => :selenium_webdriver)
        ol.should_receive(:items).and_return(5)
        ol.stub(:[])
        count = 0
        ol.each { |item| count += 1 }
        count.should == 5
      end
    end
  end
end
