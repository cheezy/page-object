require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Canvas do
  let(:area) { PageObject::Elements::Canvas }

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
    let(:canvas_element) { double('canvas_element') }

    context "when using selenium" do
      let(:selenium_canvas) { PageObject::Elements::Canvas.new(canvas_element, :platform => :selenium_webdriver) }

      it "should know its width" do
        canvas_element.should_receive(:attribute).with(:width).and_return("400")
        selenium_canvas.width.should == 400
      end

      it "should know its height" do
        canvas_element.should_receive(:attribute).with(:height).and_return("100")
        selenium_canvas.height.should == 100
      end
    end
  end
end
