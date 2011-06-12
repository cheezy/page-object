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
      [:class, :id, :name, :xpath].each do |t|
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
        ul_element.stub(:find_element)
        ul[1].should be_instance_of PageObject::Elements::ListItem
      end
    end    
    
    context "for selenium" do
      it "should return a list item when indexed" do
        ul = PageObject::Elements::UnorderedList.new(ul_element, :platform => :selenium)
        ul_element.should_receive(:find_element).and_return(ul_element)
        ul[1].should be_instance_of PageObject::Elements::ListItem
      end
    end
  end
end