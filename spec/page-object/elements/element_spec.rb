require 'spec_helper'
require 'page-object/elements'

describe "Element" do
  let(:wd) { double('') }
  let(:native) { double(wd: wd) }
  let(:element) { PageObject::Elements::Element.new(native) }

  context "interaction with native element" do
    it "should check if native is enabled" do
      expect(native).to receive(:enabled?).and_return(true)
      expect(element.enabled?).to be true
    end

    it "should click the native" do
      expect(native).to receive(:click)
      element.click
    end

    it "should double click the native" do
      expect(native).to receive(:double_click)
      element.double_click
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
      expect(native).to receive(:visible?).and_return(false)
      expect(element.visible?).to eq(false)
    end

    it "should know if a native exists" do
      expect(native).to receive(:exists?).and_return(true)
      expect(element.exists?).to be true
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
      expect(native).to receive(:attribute).and_return('bar')
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
      expect(element.focused?).to be true
    end

    it "should know if a native is not focused" do
      expect(native).to receive(:focused?).and_return(false)
      expect(element.focused?).to be false
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
      expect(native).to receive(:visible?).and_return(false)
      expect(native).to receive(:visible?).and_return(true)
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

  context 'walking the dom' do
    let(:found) { double('found').as_null_object }

    before do
      allow(found).to receive(:tag_name).and_return(:span)
    end

    it 'should find the parent object' do
      expect(native).to receive(:parent).and_return(found)
      pageobject = element.parent
      expect(pageobject).to be_a(::PageObject::Elements::Span)
      expect(pageobject.tag_name).to eql :span
    end

    it 'should find the proceeding sibling' do
      expect(native).to receive(:preceding_sibling).and_return(found)
      pageobject = element.preceding_sibling
      expect(pageobject).to be_a(::PageObject::Elements::Span)
      expect(pageobject.tag_name).to eql :span
    end

    it 'should find the following sibling' do
      expect(native).to receive(:following_sibling).and_return(found)
      pageobject = element.following_sibling
      expect(pageobject).to be_a(::PageObject::Elements::Span)
      expect(pageobject.tag_name).to eql :span
    end

    it 'should find all of its siblings' do
      expect(native).to receive(:siblings).and_return([found, found])
      results = element.siblings
      expect(results.size).to eql 2
      expect(results[0]).to be_a(::PageObject::Elements::Span)
      expect(results[1]).to be_a(::PageObject::Elements::Span)
    end

    it 'should find all of its children' do
      expect(native).to receive(:children).and_return([found, found])
      results = element.children
      expect(results.size).to eql 2
      expect(results[0]).to be_a(::PageObject::Elements::Span)
      expect(results[1]).to be_a(::PageObject::Elements::Span)
    end

    it 'should find all of the preceding siblings' do
      expect(native).to receive(:preceding_siblings).and_return([found, found])
      results = element.preceding_siblings
      expect(results.size).to eql 2
      expect(results[0]).to be_a(::PageObject::Elements::Span)
      expect(results[1]).to be_a(::PageObject::Elements::Span)
    end

    it 'should find all of the following siblings' do
      expect(native).to receive(:following_siblings).and_return([found, found])
      results = element.following_siblings
      expect(results.size).to eql 2
      expect(results[0]).to be_a(::PageObject::Elements::Span)
      expect(results[1]).to be_a(::PageObject::Elements::Span)
    end
  end
end
