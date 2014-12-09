require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Form do
  describe "interface" do
    let(:form_element) { double('form_element') }

    it "should register with tag_name :form" do
      expect(::PageObject::Elements.element_class_for(:form)).to eql ::PageObject::Elements::Form
    end

    context "for watir" do
      it "should submit a form" do
        form = PageObject::Elements::Form.new(form_element, :platform => :watir_webdriver)
        expect(form_element).to receive(:submit)
        form.submit
      end
    end

    context "for selenium" do
      it "should submit a form" do
        form = PageObject::Elements::Form.new(form_element, :platform => :selenium_webdriver)
        expect(form_element).to receive(:submit)
        form.submit
      end
    end
  end
end
