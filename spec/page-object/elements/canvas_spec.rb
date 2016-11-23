require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Canvas do
  let(:area) { PageObject::Elements::Canvas }

  context "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :xpath].each do |t|
        identifier = area.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end
  end

  context "implementation" do
    let(:canvas_element) { double('canvas_element') }
    let(:wd) { double('wd') }

    before do
      allow(canvas_element).to receive(:wd).and_return wd
    end

    context "when using watir" do
      let(:watir_canvas) { PageObject::Elements::Canvas.new(canvas_element, :platform => :watir) }

      it "should know its width" do
        expect(wd).to receive(:size).and_return({'width' => 400})
        expect(watir_canvas.width).to eql 400
      end

      it "should know its height" do
        expect(wd).to receive(:size).and_return({'height' => 100})
        expect(watir_canvas.height).to eql 100
      end
    end
  end
end
