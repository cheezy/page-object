require 'spec_helper'
require 'page-object/elements'


describe "Element" do

  context "when building the identifiers for Watir" do
    it "should build xpath when finding elements by name where not supported" do
      ['table', 'span', 'div', 'td', 'li', 'ol', 'ul'].each do |tag|
        how = {:tag_name => tag, :name => 'blah'}
        result = PageObject::Elements::Element.watir_identifier_for how
        expect(result[:xpath]).to eql ".//#{tag}[@name='blah']"
      end
    end
  end

  context "interaction with native element" do
    let(:wd) { double('') }
    let(:native) { double(wd: wd) }
    let(:element) { PageObject::Elements::Element.new(native, :platform => :watir) }

    it "should check if native is enabled" do
      expect(native).to receive(:enabled?).and_return(true)
      expect(element).to be_enabled
    end

    it "should click the native" do
      expect(native).to receive(:click)
      element.click
    end

    it "should double click the native" do
      expect(native).to receive(:double_click)
      element.double_click
    end

    it "should drag and drop the native" do
      expect(native).to receive(:drag_and_drop_on).with(native)
      element.drag_and_drop_on element
    end

    it 'should fail to drag and drop the native on a non-element' do
      expect{element.drag_and_drop_on :not_element}.to raise_error ArgumentError
    end

    it "should inspect the native" do
      expect(native).to receive(:inspect)
      element.inspect
    end

    it "should retrieve the native's style" do
      expect(native).to receive(:style).with('foo').and_return("cheezy_style")
      expect(element.style('foo')).to eql 'cheezy_style'
    end

    it "should know if a native is disabled" do
      expect(native).to receive(:enabled?).and_return(false)
      expect(element).to be_disabled
    end

    it "should know if a native is visible" do
      expect(native).to receive(:present?).and_return(false)
      expect(element.visible?).to eq(false)
    end

    it "should know if a native exists" do
      expect(native).to receive(:exists?).and_return(true)
      expect(element).to exist
    end

    it "should flash the native" do
      expect(native).to receive(:flash)
      element.flash
    end

    it "should inspect the native's text" do
      expect(native).to receive(:text).and_return('My value is 42')
      expect(element.text).to eq('My value is 42')
    end

    it "should inspect the native's html" do
      expect(native).to receive(:html).and_return('<p>42</p>')
      expect(element.html).to eq('<p>42</p>')
    end

    it "should inspect the native's value" do
      expect(native).to receive(:html).and_return('42')
      expect(element.html).to eq('42')
    end

    it "should inspect the native's tag name" do
      expect(native).to receive(:attribute_value).and_return('bar')
      expect(element.attribute('foo')).to eq('bar')
    end

    it "should fire the native's event" do
      expect(native).to receive(:fire_event).with('hello')
      element.fire_event('hello')
    end

    it "should hover" do
      expect(native).to receive(:hover)
      element.hover
    end

    it "should focus" do
      expect(native).to receive(:focus)
      element.focus
    end

    it "should know if a native is focused" do
      expect(native).to receive(:focused?).and_return(true)
      expect(element).to be_focused
    end

    it "should know if a native is not focused" do
      expect(native).to receive(:focused?).and_return(false)
      expect(element).to_not be_focused
    end

    it "should select the native's text" do
      expect(native).to receive(:select_text).with('hello')
      element.select_text('hello')
    end

    it "should wait until present" do
      expect(native).to receive(:wait_until).with(timeout: 42, message: "Element not present in 42 seconds")
      element.when_present(42)
    end

    it 'should check if the element is visible' do
      expect(native).to receive(:present?).and_return(false)
      expect(native).to receive(:present?).and_return(true)
      expect(element.check_visible).to be true
    end

    it 'should check if the element exists' do
      expect(native).to receive(:exists?).twice.and_return(false)
      expect(native).to receive(:exists?).and_return(true)
      expect(element.check_exists).to be true
    end

    it "should send keys" do
      expect(native).to receive(:send_keys).with('foo bar')
      element.send_keys('foo bar')
    end

    it "should clear" do
      expect(native).to receive(:clear)
      element.clear
    end

    it "should inspect the native's id" do
      expect(native).to receive(:id).and_return('element123')
      expect(element.id).to eq('element123')
    end

    it "should scroll the element into view" do
      expect(wd).to receive(:location_once_scrolled_into_view)
      expect(native).to receive(:wd).and_return(wd)
      element.scroll_into_view
    end

    it 'should return the outer html' do
      expect(native).to receive(:outer_html).and_return("<div>blah</div>")
      element.outer_html
    end

    it 'should return the inner html' do
      expect(native).to receive(:inner_html).and_return('blah')
      element.inner_html
    end

    it 'should know if it is stale' do
      expect(native).to receive(:stale?).and_return(false)
      expect(element.stale?).to be false
    end
  end
end
