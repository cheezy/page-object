require 'spec_helper'
require 'page-object/elements'

describe PageObject::Elements::CheckBox do
  let(:checkbox) { PageObject::Elements::CheckBox }

  describe "interface" do
    let(:check_box) { double('check_box') }
    let(:selenium_cb) { PageObject::Elements::CheckBox.new(check_box, :platform => :selenium_webdriver) }

    it "should register with type :checkbox" do
      expect(::PageObject::Elements.element_class_for(:input, :checkbox)).to eql ::PageObject::Elements::CheckBox
    end
  end
end
