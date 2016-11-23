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
  end

  describe "interface" do
    let(:sel_list) { double('select_list') }
    let(:opts) { [sel_list, sel_list] }

    before(:each) do
      allow(sel_list).to receive(:find_elements).and_return(sel_list)
      allow(sel_list).to receive(:each)
      allow(sel_list).to receive(:wd).and_return(sel_list)
      allow(sel_list).to receive(:map).and_return(opts)
      allow(sel_list).to receive(:any?)
      allow(sel_list).to receive(:include?)
      allow(sel_list).to receive(:select).and_return(opts)
      allow(sel_list).to receive(:text).and_return('blah')
    end

    it "should register with tag_name :select" do
      expect(::PageObject::Elements.element_class_for(:select)).to eql ::PageObject::Elements::SelectList
    end

    context "for watir" do
      let(:watir_sel_list) { PageObject::Elements::SelectList.new(sel_list, :platform => :watir) }

      it "should return an option when indexed" do
        expect(sel_list).to receive(:options).with(no_args).and_return(opts)
        expect(watir_sel_list[0]).to be_instance_of PageObject::Elements::Option
      end

      it "should return an array of options" do
        expect(sel_list).to receive(:options).with(no_args).and_return(opts)
        expect(watir_sel_list.options.size).to eql 2
      end

      it "should return an array of selected options" do
        allow(sel_list).to receive(:selected_options).and_return(opts)
        allow(sel_list).to receive(:text).and_return(sel_list)
        expect(watir_sel_list.selected_options).to eql opts
      end

      it "should know if it includes some value" do
        allow(sel_list).to receive(:include?).with('blah').and_return(true)
        watir_sel_list.include?('blah')
      end

      it "should know if an option is selected" do
        allow(sel_list).to receive(:selected?).with('blah').and_return(true)
        watir_sel_list.selected?('blah')
      end

      it "should be able to get the value for the selected options" do
        allow(sel_list).to receive(:selected_options).and_return(opts)
        allow(sel_list).to receive(:value).and_return(sel_list)
        expect(watir_sel_list.selected_values).to eql opts
      end
    end
  end
end
