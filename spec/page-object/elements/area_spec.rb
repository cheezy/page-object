require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Area do
  let(:area) { PageObject::Elements::Area }

  context "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        identifier = area.watir_identifier_for t => 'value'
        identifier.keys.first.should == t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        key, value = area.selenium_identifier_for t => 'value'
        key.should == t
      end
    end
  end

  context "implementation" do
    let(:area_element) { double('area_element') }

    context "when using watir" do
      let(:watir_area) { PageObject::Elements::Area.new(area_element, :platform => :watir_webdriver) }

      it "should know its coords" do
        area_element.should_receive(:attribute_value).with(:coords).and_return("1,2,3,4")
        watir_area.coords.should == "1,2,3,4"
      end

      it "should know its shape" do
        area_element.should_receive(:attribute_value).with(:shape).and_return('circle')
        watir_area.shape.should == 'circle'
      end

      it "should know its hre" do
        area_element.should_receive(:attribute_value).with(:href).and_return('twitter.com')
        watir_area.href.should == 'twitter.com'
      end
    end
  end
end
