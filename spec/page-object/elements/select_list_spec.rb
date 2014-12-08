require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::SelectList do
  let(:selectlist) { PageObject::Elements::SelectList }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :text, :value, :xpath].each do |t|
        identifier = selectlist.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :name, :xpath, :index].each do |t|
        key, value = selectlist.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end
  end

  describe "interface" do
    let(:sel_list) { double('select_list') }
    let(:opts) { [sel_list, sel_list] }

    before(:each) do
      sel_list.stub(:find_elements).and_return(sel_list)
      sel_list.stub(:each)
      sel_list.stub(:wd).and_return(sel_list)
      sel_list.stub(:map).and_return(opts)
      sel_list.stub(:any?)
      sel_list.stub(:include?)
      sel_list.stub(:select).and_return(opts)
      sel_list.stub(:text).and_return('blah')
    end

    it "should register with tag_name :select" do
      expect(::PageObject::Elements.element_class_for(:select)).to eql ::PageObject::Elements::SelectList
    end

    context "for watir" do
      let(:watir_sel_list) { PageObject::Elements::SelectList.new(sel_list, :platform => :watir_webdriver) }

      it "should return an option when indexed" do
        sel_list.should_receive(:find_elements).with(:xpath, ".//child::option").and_return(opts)
        expect(watir_sel_list[0]).to be_instance_of PageObject::Elements::Option
      end

      it "should return an array of options" do
        sel_list.should_receive(:find_elements).with(:xpath, ".//child::option").and_return(opts)
        expect(watir_sel_list.options.size).to eql 2
      end

      it "should return an array of selected options" do
        sel_list.stub(:selected_options).and_return(opts)
        sel_list.stub(:text).and_return(sel_list)
        expect(watir_sel_list.selected_options).to eql opts
      end

      it "should know if it includes some value" do
        sel_list.stub(:include?).with('blah').and_return(true)
        watir_sel_list.include?('blah')
      end

      it "should know if an option is selected" do
        sel_list.stub(:selected?).with('blah').and_return(true)
        watir_sel_list.selected?('blah')
      end

      it "should be able to get the value for the selected options" do
        sel_list.stub(:selected_options).and_return(opts)
        sel_list.stub(:value).and_return(sel_list)
        expect(watir_sel_list.selected_values).to eql opts
      end
    end

    context "for selenium"  do
      let(:selenium_sel_list) { PageObject::Elements::SelectList.new(sel_list, :platform => :selenium_webdriver) }

      it "should return an option when indexed" do
        sel_list.should_receive(:find_elements).with(:xpath, ".//child::option").and_return(opts)
        expect(selenium_sel_list[1]).to be_instance_of PageObject::Elements::Option
      end

      it "should return an array of options" do
        sel_list.should_receive(:find_elements).with(:xpath, ".//child::option").and_return(opts)
        expect(selenium_sel_list.options.size).to eql 2
      end

      it "should select an element" do
        option = double('option')
        sel_list.should_receive(:find_elements).with(:xpath, ".//child::option").and_return([option])
        option.should_receive(:text).and_return('something')
        option.should_receive(:click)
        selenium_sel_list.select 'something'
      end

      it "should return an array of selected options" do
        sel_list.should_receive(:find_elements).with(:xpath, ".//child::option").and_return(opts)
        opts[0].should_receive(:selected?).and_return(true)
        opts[0].should_receive(:text).and_return('test1')
        opts[1].should_receive(:selected?).and_return(false)
        selected = selenium_sel_list.selected_options
        expect(selected.size).to eql 1
        expect(selected[0]).to eql 'test1'
      end

      it "should return an array of selected options" do
        sel_list.should_receive(:find_elements).with(:xpath, ".//child::option").and_return(opts)
        opts[0].should_receive(:selected?).and_return(true)
        opts[0].should_receive(:attribute).and_return('test1')
        opts[1].should_receive(:selected?).and_return(false)
        selected = selenium_sel_list.selected_values
        expect(selected.size).to eql 1
        expect(selected[0]).to eql 'test1'
      end

      it "should know if it includes some value" do
        sel_list.should_receive(:find_elements).and_return(opts)
        opts[0].should_receive(:text).and_return('blah')
        expect(selenium_sel_list).to include 'blah'
      end

      it "should know if an option is selected" do
        sel_list.should_receive(:find_elements).and_return(opts)
        opts[0].should_receive(:selected?).twice.and_return(true)
        opts[0].should_receive(:text).and_return('blah')
        expect(selenium_sel_list.selected?('blah')).to be true
      end

      it "should be able to clear selected options" do
        sel_list.should_receive(:find_elements).and_return(opts)
        opts.each do |opt|
          opt.should_receive(:selected?).and_return(true)
          opt.should_receive(:click)
        end
        selenium_sel_list.clear
      end
    end
  end
end
