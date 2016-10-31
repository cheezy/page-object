require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::Button do
  let(:button) { PageObject::Elements::Button }

  context "when mapping how to find an element" do
    it "should map watir types to same" do
      [:class, :id, :index, :name, :value, :xpath, :src, :alt, :css].each do |t|
        identifier = button.watir_identifier_for t => 'value'
        expect(identifier.keys.first).to eql t
      end
    end

    it "should map selenium types to same" do
      [:class, :id, :index, :name, :value, :xpath, :src, :alt, :css].each do |t|
        key, value = button.selenium_identifier_for t => 'value'
        expect(key).to eql t
      end
    end
  end

  describe "interface" do
    let(:button_element) { double('button_element') }

    it "should register with type :submit" do
      expect(::PageObject::Elements.element_class_for(:input, :submit)).to eql ::PageObject::Elements::Button
    end

    it "should register with type :image" do
      expect(::PageObject::Elements.element_class_for(:input, :image)).to eql ::PageObject::Elements::Button
    end

    it "should register with type :button" do
      expect(::PageObject::Elements.element_class_for(:input, :button)).to eql ::PageObject::Elements::Button
    end

    it "should register with type :reset" do
      expect(::PageObject::Elements.element_class_for(:input, :reset)).to eql ::PageObject::Elements::Button
    end

    context "for selenium" do
      it "should return text for a button tag button" do
        allow(button_element).to receive(:tag_name).and_return('button')
        allow(button_element).to receive(:text).and_return('button?')
        button = PageObject::Elements::Button.new(button_element, :platform => :selenium_webdriver)
        expect(button.text).to eq 'button?'
      end

      it "should return text for an input tag button" do
        allow(button_element).to receive(:tag_name).and_return('input')
        allow(button_element).to receive(:attribute).with('value').and_return('button!')
        button = PageObject::Elements::Button.new(button_element, :platform => :selenium_webdriver)
        expect(button.text).to eq 'button!'
      end
    end
  end

end
