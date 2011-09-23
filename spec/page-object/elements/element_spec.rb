require 'spec_helper'
require 'page-object/elements'


describe "Element class methods" do

  context "when handling unknown requests" do
    it "should delegate to the driver element" do
      watir_driver = double('watir')
      watir_element = PageObject::Elements::Element.new(watir_driver, :platform => :watir_webdriver)
      watir_driver.should_receive(:do_this)
      watir_element.do_this
    end
  end

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
      ['text', 'hidden', 'checkbox', 'radio', 'submit']
    end

    it "should build xpath when index is provided for basic elements" do
      all_basic_elements.each do |tag|
        identifier = {:tag_name => tag, :index => 1}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        how.should == :xpath
        what.should == ".//#{tag}[2]"
      end
    end

    it "should should build xpath when index is provided for input elements" do
      all_input_elements.each do |tag|
        identifier = {:tag_name => 'input', :type => tag, :index => 1}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        how.should == :xpath
        what.should == ".//input[@type='#{tag}'][2]"
      end
    end

    it "should build xpath when locating basic elements by name and index" do
      all_basic_elements.each do |tag|
        identifier = {:tag_name => tag, :name => 'blah', :index => 0}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        how.should == :xpath
        what.should == ".//#{tag}[@name='blah'][1]"
      end
    end

    it "should build xpath when locating input elements by name and index" do
      all_input_elements.each do |type|
        identifier = {:tag_name => 'input', :type => "#{type}", :name => 'blah', :index => 0}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        how.should == :xpath
        what.should == ".//input[@type='#{type}' and @name='blah'][1]"
      end
    end

    it "should build xpath when locating basic elements by name and class" do
      all_basic_elements.each do |tag|
        identifier = {:tag_name => tag, :name => 'foo', :class => 'bar'}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        how.should == :xpath
        what.should == ".//#{tag}[@name='foo' and @class='bar']"
      end
    end

    it "should build xpath when locating input elements by name and class" do
      all_input_elements.each do |type|
        identifier = {:tag_name => 'input', :type => "#{type}", :name => 'foo', :class => 'bar'}
        how, what = PageObject::Elements::Element.selenium_identifier_for identifier
        what.should == ".//input[@type='#{type}' and @name='foo' and @class='bar']"
      end
    end
  end  
end