require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::UnorderedList do
  let(:ul) { PageObject::Elements::UnorderedList }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :xpath].each do |t|
        identifier = ul.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        key, value = ul.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end

  describe "interface" do
    let(:ul_element) { double('ul_element') }

    it "should register with tag_name :ul" do
      ::PageObject::Elements.element_class_for(:ul).should == ::PageObject::Elements::UnorderedList
    end

    context "for watir" do
      it "should return a list item when indexed" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :watir_webdriver)
        ul_element.stub(:uls).and_return([ul_element])
        ul_element.stub(:find_elements).and_return(ul_element)
        ul_element.stub(:map).and_return([ul_element])
        ul_element.stub(:parent).and_return(ul_element)
        ul_element.stub(:element).and_return(ul_element)
        ul_element.stub(:==).and_return(true)
        ul[1]
      end

      it "should know how many items it contains" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :watir_webdriver)
        ul_element.stub(:uls).and_return([ul_element])
        ul_element.stub(:find_elements).and_return(ul_element)
        ul_element.stub(:map).and_return([ul_element])
        ul_element.stub(:parent).and_return(ul_element)
        ul_element.stub(:element).and_return(ul_element)
        ul_element.stub(:==).and_return(true)
        ul.items.should == 1
      end

      it "should know how to iterate over the items" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :watir_webdriver)
        ul.should_receive(:items).and_return(5)
        ul.stub(:[])
        count = 0
        ul.each { |item| count += 1 }
        count.should == 5
      end
    end

    context "for selenium" do
      it "should return a list item when indexed" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :selenium_webdriver)
        ul_element.should_receive(:find_elements).and_return(ul_element)
        ul_element.should_receive(:map).and_return([ul_element])
        ul_element.should_receive(:parent).and_return(ul_element)
        ul_element.should_receive(:element).and_return(ul_element)
        ul_element.should_receive(:==).and_return(true)
        ul[1]
      end

      it "should know how many items it contains" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :selenium_webdriver)
        ul_element.should_receive(:find_elements).and_return(ul_element)
        ul_element.should_receive(:map).and_return([ul_element])
        ul_element.should_receive(:parent).and_return(ul_element)
        ul_element.should_receive(:element).and_return(ul_element)
        ul_element.should_receive(:==).and_return(true)
        ul.items.should == 1
      end

      it "should know how to iterate over the items" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :selenium_webdriver)
        ul.should_receive(:items).and_return(5)
        ul.stub(:[])
        count = 0
        ul.each { |item| count += 1 }
        count.should == 5

      end
    end
  end
end
