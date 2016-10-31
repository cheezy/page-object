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

  context "when building the identifiers for Selenium" do
    def all_basic_elements
      ['textarea', 'select', 'a', 'div', 'span', 'table', 'td', 'img', 'form', 'li', 'ul', 'ol']
    end

    def all_input_elements
      ['text', 'hidden', 'checkbox', 'radio']
    end

    it "should build xpath when index is provided for basic elements" do
      all_basic_elements.each do |tag|
        identifier = {:tag_name => tag, :index => 1}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        expect(how).to eql :xpath
        expect(what).to eql "(.//#{tag})[2]"
      end
    end

    it "should should build xpath when index is provided for input elements" do
      all_input_elements.each do |tag|
        identifier = {:tag_name => 'input', :type => tag, :index => 1}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        expect(how).to eql :xpath
        expect(what).to include "(.//input[@type='#{tag}'])[2]"
      end
    end

    it "should build xpath when locating basic elements by name and index" do
      all_basic_elements.each do |tag|
        identifier = {:tag_name => tag, :name => 'blah', :index => 0}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        expect(how).to eql :xpath
        expect(what).to eql "(.//#{tag}[@name='blah'])[1]"
      end
    end

    it "should build xpath when locating input elements by name and index" do
      all_input_elements.each do |type|
        identifier = {:tag_name => 'input', :type => "#{type}", :name => 'blah', :index => 0}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        expect(how).to eql :xpath
        expect(what).to include "(.//input[@type='#{type}' and @name='blah'])[1]"
      end
    end

    it "should build xpath when locating basic elements by name and class" do
      all_basic_elements.each do |tag|
        identifier = {:tag_name => tag, :class => 'bar', :name => 'foo'}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        expect(how).to eql :xpath
        expect(what).to eql ".//#{tag}[@class='bar' and @name='foo']"
      end
    end

    it "should build xpath when locating input elements by name and class" do
      all_input_elements.each do |type|
        identifier = {:tag_name => 'input', :type => "#{type}", :class => 'bar', :name => 'foo'}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        expect(what).to include ".//input[@type='#{type}' and @class='bar' and @name='foo']"
      end
    end
  end

  context "interaction with native element" do
    let(:wd) { double('') }
    let(:native) { double(wd: wd) }
    let(:element) { PageObject::Elements::Element.new(native, :platform => :watir_webdriver) }

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

    it "should select the native's text" do
      expect(native).to receive(:select_text).with('hello')
      element.select_text('hello')
    end

    it "should wait until present" do
      expect(native).to receive(:wait_until_present).with(42)
      element.when_present(42)
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

    it "should inspect the native's id" do
      expect(wd).to receive(:location_once_scrolled_into_view)
      expect(native).to receive(:wd).and_return(wd)
      element.scroll_into_view
    end
  end
end
