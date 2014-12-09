require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Area do
  let(:area) { PageObject::Elements::Area }

  context "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        identifier = area.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        key, value = area.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end
  end

  context "implementation" do
    let(:area_element) { double('area_element') }

    context "when using selenium" do
      let(:selenium_area) { PageObject::Elements::Area.new(area_element, :platform => :selenium_webdriver) }
      
      it "should know its coords" do
        expect(area_element).to receive(:attribute).with(:coords).and_return("1,2,3,4")
        expect(selenium_area.coords).to eql "1,2,3,4"
      end

      it "should know its shape" do
        expect(area_element).to receive(:attribute).with(:shape).and_return('circle')
        expect(selenium_area.shape).to eql 'circle'
      end

      it "should know its href" do
        expect(area_element).to receive(:attribute).with(:href).and_return('twitter.com')
        expect(selenium_area.href).to eql 'twitter.com'
      end
    end
  end
end
