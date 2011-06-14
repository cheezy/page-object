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
      [:class, :id, :name, :xpath].each do |t|
        key, value = ol.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end
  
  describe "interface" do
    let(:ol_element) { double('ol_element') }
        
    context "for watir" do
      it "should return a list item when indexed" do
        ol = PageObject::Elements::OrderedList.new(ol_element, :platform => :watir)
        ol_element.stub(:wd).and_return(ol_element)
        ol_element.should_receive(:find_elements).with(:xpath, ".//child::li").and_return(ol_element)
        ol_element.stub(:[]).and_return(ol_element)
        ol[1].should be_instance_of PageObject::Elements::ListItem
      end
    end    
    
    context "for selenium" do
      it "should return a list item when indexed" do
        ol = PageObject::Elements::OrderedList.new(ol_element, :platform => :selenium)
        ol_element.should_receive(:find_elements).with(:xpath, ".//child::li").and_return(ol_element)
        ol_element.should_receive(:[]).and_return(ol_element)
        ol[1].should be_instance_of PageObject::Elements::ListItem
      end
    end
  end
end