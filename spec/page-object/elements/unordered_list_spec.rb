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

    context "for watir" do
      it "should return a list item when indexed" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :watir)
        ul_element.stub(:wd).and_return(ul_element)
        ul_element.stub(:find_elements).and_return(ul_element)
        ul_element.stub(:[])
        ul[1].should be_instance_of PageObject::Elements::ListItem
      end

      it "should know how many items it contains" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :watir)
        ul_element.stub(:wd).and_return(ul_element)
        ul_element.stub(:find_elements).and_return(ul_element)
        ul_element.stub(:size).and_return(5)
        ul.items.should == 5
      end

      it "should know how to iterate over the items" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :watir)
        ul.should_receive(:items).and_return(5)
        ul.stub(:[])
        count = 0
        ul.each { |item| count += 1 }
        count.should == 5
      end
    end

    context "for selenium" do
      it "should return a list item when indexed" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :selenium)
        ul_element.should_receive(:find_elements).and_return(ul_element)
        ul_element.stub(:[])
        ul[1].should be_instance_of PageObject::Elements::ListItem
      end

      it "should know how many items it contains" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :selenium)
        ul_element.should_receive(:find_elements).and_return(ul_element)
        ul_element.should_receive(:size).and_return(5)
        ul.items.should == 5
      end

      it "should know how to iterate over the items" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :selenium)
        ul.should_receive(:items).and_return(5)
        ul.stub(:[])
        count = 0
        ul.each { |item| count += 1 }
        count.should == 5

      end
    end
  end
end