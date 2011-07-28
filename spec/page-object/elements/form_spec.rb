require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Form do
  describe "interface" do
    let(:form_element) { double('form_element') }

    context "for watir" do
      it "should submit a form" do
        form = PageObject::Elements::Form.new(form_element, :platform => :watir)
        form_element.should_receive(:submit)
        form.submit
      end
    end

    context "for selenium" do
      it "should submit a form" do
        form = PageObject::Elements::Form.new(form_element, :platform => :selenium)
        form_element.should_receive(:submit)
        form.submit
      end
    end
  end
end