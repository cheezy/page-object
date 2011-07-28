require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Link do
  let(:link) { PageObject::Elements::Link }

  describe "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :href, :id, :index, :name, :text, :xpath].each do |t|
        identifier = link.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to watir" do
      [:link, :link_text].each do |t|
        identifier = link.watir_identifier_for t => 'value'
        identifier.keys.first.should == :text
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :link, :link_text, :name, :xpath, :index].each do |t|
        key, value = link.selenium_identifier_for t => 'value'
        key.should == t
      end
    end

    it "should map watir types to selenium" do
      key, value = link.selenium_identifier_for :text => 'value'
      key.should == :link_text
    end
  end

  describe "interface" do
    let(:link_element) { double('link_element') }

    context "for selenium" do
      it "should return error when asked for its' value" do
        link = PageObject::Elements::Link.new(link_element, :platform => :selenium)
        lambda { link.value }.should raise_error
      end
    end
  end
end