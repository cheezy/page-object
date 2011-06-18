require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::SelectList do
  let(:selectlist) { PageObject::Elements::SelectList }
  
  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :text, :value, :xpath].each do |t|
        identifier = selectlist.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :name, :xpath].each do |t|
        key, value = selectlist.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end

  describe "interface" do
    let(:sel_list) { double('select_list') }

    before(:each) do
      sel_list.stub(:find_elements).and_return(sel_list)
    end
    
    context "for watir" do
      it "should return an option when indexed" do
        watir_sel_list = PageObject::Elements::SelectList.new(sel_list, :platform => :watir)
        sel_list.stub(:options).and_return(sel_list)
        sel_list.should_receive(:[]).with(1).and_return(sel_list)
        watir_sel_list[1].should be_instance_of PageObject::Elements::Option
      end
    end

    context "for selenium" do
      it "should return an option when indexed" do
        selenium_sel_list = PageObject::Elements::SelectList.new(sel_list, :platform => :selenium)
        sel_list.should_receive(:find_elements).with(:xpath, ".//child::option").and_return(sel_list)
        sel_list.should_receive(:[]).with(1).and_return(sel_list)
        selenium_sel_list[1].should be_instance_of PageObject::Elements::Option
      end
    end
  end
end
