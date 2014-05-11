require 'spec_helper'
require 'page-object/elements'


describe "Element" do

  context "when building the identifiers for Watir" do
    it "should build xpath when finding elements by name where not supported" do
      ['table', 'span', 'div', 'td', 'li', 'ol', 'ul'].each do |tag|
        how = {:tag_name => tag, :name => 'blah'}
        result = PageObject::Elements::Element.watir_identifier_for how
        result[:xpath].should == ".//#{tag}[@name='blah']"
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
        how.should == :xpath
        what.should == "(.//#{tag})[2]"
      end
    end

    it "should should build xpath when index is provided for input elements" do
      all_input_elements.each do |tag|
        identifier = {:tag_name => 'input', :type => tag, :index => 1}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        how.should == :xpath
        what.should include "(.//input[@type='#{tag}'])[2]"
      end
    end

    it "should build xpath when locating basic elements by name and index" do
      all_basic_elements.each do |tag|
        identifier = {:tag_name => tag, :name => 'blah', :index => 0}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        how.should == :xpath
        what.should == "(.//#{tag}[@name='blah'])[1]"
      end
    end

    it "should build xpath when locating input elements by name and index" do
      all_input_elements.each do |type|
        identifier = {:tag_name => 'input', :type => "#{type}", :name => 'blah', :index => 0}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        how.should == :xpath
        what.should include "(.//input[@type='#{type}' and @name='blah'])[1]"
      end
    end

    it "should build xpath when locating basic elements by name and class" do
      all_basic_elements.each do |tag|
        identifier = {:tag_name => tag, :class => 'bar', :name => 'foo'}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        how.should == :xpath
        what.should == ".//#{tag}[@class='bar' and @name='foo']"
      end
    end

    it "should build xpath when locating input elements by name and class" do
      all_input_elements.each do |type|
        identifier = {:tag_name => 'input', :type => "#{type}", :class => 'bar', :name => 'foo'}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        what.should include ".//input[@type='#{type}' and @class='bar' and @name='foo']"
      end
    end
  end

  context "interaction with native element" do
    let(:native) { double('') }
    let(:element) { PageObject::Elements::Element.new(native, :platform => :watir_webdriver) }

    it "should check if native is enabled" do
      native.should_receive(:enabled?).and_return(true)
      element.should be_enabled
    end

    it "should click the native" do
      native.should_receive(:click)
      element.click
    end

    it "should double click the native" do
      native.should_receive(:double_click)
      element.double_click
    end

    it "should inspect the native" do
      native.should_receive(:inspect)
      element.inspect
    end

    it "should retrieve the native's style" do
      native.should_receive(:style).with('foo').and_return("cheezy_style")
      element.style('foo').should == 'cheezy_style'
    end

    it "should know if a native is disabled" do
      native.should_receive(:enabled?).and_return(false)
      element.should be_disabled
    end
  end
end
