require 'spec_helper'
require 'page-object/elements'


describe PageObject::Elements::Element do
  let(:watir_driver) { double('watir') }
  let(:selenium_driver) { double('selenium') }
  let(:watir_element) { PageObject::Elements::Element.new(watir_driver, :platform => :watir) }
  let(:selenium_element) { PageObject::Elements::Element.new(selenium_driver, :platform => :selenium) }
  let(:element) { PageObject::Elements::Element }

  context "when handling unknown requests" do
    it "should delegate to the driver element" do
      watir_driver.should_receive(:do_this)
      watir_element.do_this
    end
  end

  context "when building the identifiers for Watir" do
    it "should build xpath when finding elements by name where not supported" do
      ['table', 'span', 'div', 'td', 'li', 'ol', 'ul'].each do |tag|
        how = {:tag_name => tag, :name => 'blah'}
        result = element.watir_identifier_for how
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
        how, what = element.selenium_identifier_for identifier
        how.should == :xpath
        what.should == ".//#{tag}[2]"
      end
    end

    it "should should build xpath when index is provided for input elements" do
      all_input_elements.each do |tag|
        identifier = {:tag_name => 'input', :type => tag, :index => 1}
        how, what = element.selenium_identifier_for identifier
        how.should == :xpath
        what.should == ".//input[@type='#{tag}'][2]"
      end
    end

    it "should build xpath when locating basic elements by name and index" do
      all_basic_elements.each do |tag|
        identifier = {:tag_name => tag, :name => 'blah', :index => 0}
        how, what = element.selenium_identifier_for identifier
        how.should == :xpath
        what.should == ".//#{tag}[@name='blah'][1]"
      end
    end

    it "should build xpath when locating input elements by name and index" do
      all_input_elements.each do |type|
        identifier = {:tag_name => 'input', :type => "#{type}", :name => 'blah', :index => 0}
        how, what = element.selenium_identifier_for identifier
        how.should == :xpath
        what.should == ".//input[@type='#{type}' and @name='blah'][1]"
      end
    end

    it "should build xpath when locating basic elements by name and class" do
      all_basic_elements.each do |tag|
        identifier = {:tag_name => tag, :name => 'foo', :class => 'bar'}
        how, what = element.selenium_identifier_for identifier
        how.should == :xpath
        what.should == ".//#{tag}[@name='foo' and @class='bar']"
      end
    end

    it "should build xpath when locating input elements by name and class" do
      all_input_elements.each do |type|
        identifier = {:tag_name => 'input', :type => "#{type}", :name => 'foo', :class => 'bar'}
        how, what = element.selenium_identifier_for identifier
        what.should == ".//input[@type='#{type}' and @name='foo' and @class='bar']"
      end
    end
  end

  context "when using Watir" do
    it "should know when it is visible" do
      watir_driver.should_receive(:present?).and_return(true)
      watir_element.visible?.should == true
    end

    it "should know when it is not visible" do
      watir_driver.should_receive(:present?).and_return(false)
      watir_element.visible?.should == false
    end

    it "should know when it exists" do
      watir_driver.should_receive(:exists?).and_return(true)
      watir_element.exists?.should == true
    end

    it "should know when it does not exist" do
      watir_driver.should_receive(:exists?).and_return(false)
      watir_element.exists?.should == false
    end

    it "should be able to return the text contained in the element" do
      watir_driver.should_receive(:text).and_return("my text")
      watir_element.text.should == "my text"
    end

    it "should know when it is equal to another" do
      watir_driver.should_receive(:==).and_return(true)
      watir_element.should == watir_element
    end

    it "should return its tag name" do
      watir_driver.should_receive(:tag_name).and_return("h1")
      watir_element.tag_name.should == "h1"
    end

    it "should know its value" do
      watir_driver.should_receive(:value).and_return("value")
      watir_element.value.should == "value"
    end

    it "should know how to retrieve the value of an attribute" do
      watir_driver.should_receive(:attribute_value).and_return(true)
      watir_element.attribute("readonly").should be_true
    end

    it "should be clickable" do
      watir_driver.should_receive(:click)
      watir_element.click
    end
    
    it "should be double clickable" do
      watir_driver.should_receive(:double_click)
      watir_element.double_click
    end
    
    it "should be right clickable" do
      watir_driver.should_receive(:right_click)
      watir_element.right_click
    end

    it "should be able to block until it is present" do
      watir_driver.should_receive(:wait_until_present).with(10)
      watir_element.when_present(10)
    end

    it "should be able to block until it is visible" do
      Watir::Wait.should_receive(:until).with(10, "Element was not visible in 10 seconds")
      watir_element.when_visible(10)
    end

    it "should be able to block until it is not visible" do
      Watir::Wait.should_receive(:while).with(10, "Element still visible after 10 seconds")
      watir_element.when_not_visible(10)
    end

    it "should be able to block until a user define event fires true" do
      Watir::Wait.should_receive(:until).with(10, "Element blah")
      watir_element.wait_until(10, "Element blah") {}
    end
    
    it "should send keys to the element" do
      watir_driver.should_receive(:send_keys).with([:control, 'a'])
      watir_element.send_keys([:control, 'a'])
    end
    
    it "should clear its' contents" do
      watir_driver.should_receive(:clear)
      watir_element.clear
    end
    
  end

  context "when using Selenium" do
    it "should know when it is visible" do
      selenium_driver.should_receive(:displayed?).and_return(true)
      selenium_element.visible?.should == true
    end

    it "should know when it is not visible" do
      selenium_driver.should_receive(:displayed?).and_return(false)
      selenium_element.visible?.should == false
    end

    it "should know when it exists" do
      selenium_element.exists?.should == true
    end

    it "should know when it does not exist" do
      selenium_element = PageObject::Elements::Element.new(nil, :platform => :selenium)
      selenium_element.exists?.should == false
    end

    it "should be able to return the text contained in the element" do
      selenium_driver.should_receive(:text).and_return("my text")
      selenium_element.text.should == "my text"
    end

    it "should know when it is equal to another" do
      selenium_driver.should_receive(:==).and_return(true)
      selenium_element.should == selenium_element
    end

    it "should return its tag name" do
      selenium_driver.should_receive(:tag_name).and_return("h1")
      selenium_element.tag_name.should == "h1"
    end

    it "should know its value" do
      selenium_driver.should_receive(:attribute).with('value').and_return("value")
      selenium_element.value.should == "value"
    end

    it "should know how to retrieve the value of an attribute" do
      selenium_driver.should_receive(:attribute).and_return(true)
      selenium_element.attribute('readonly').should be_true
    end

    it "should be clickable" do
      selenium_driver.should_receive(:click)
      selenium_element.click
    end

    it "should be double clickable" do
      selenium_driver.should_receive(:double_click)
      selenium_element.double_click
    end
    
    it "should be right clickable" do
      selenium_driver.should_receive(:context_click)
      selenium_element.right_click
    end

    it "should be able to block until it is present" do
      wait = double('wait')
      Object::Selenium::WebDriver::Wait.should_receive(:new).and_return(wait)
      wait.should_receive(:until)
      selenium_element.when_present(10)
    end

    it "should be able to block until it is visible" do
      wait = double('wait')
      Object::Selenium::WebDriver::Wait.should_receive(:new).and_return(wait)
      wait.should_receive(:until)
      selenium_element.when_visible(10)
    end

    it "should be able to block until it is not visible" do
      wait = double('wait')
      Object::Selenium::WebDriver::Wait.should_receive(:new).and_return(wait)
      wait.should_receive(:until)
      selenium_element.when_not_visible(10)
    end

    it "should be able to block until a user define event fires true" do
      wait = double('wait')
      Object::Selenium::WebDriver::Wait.should_receive(:new).and_return(wait)
      wait.should_receive(:until)
      selenium_element.wait_until(10, "Element blah") {}
    end

    it "should send keys to the element" do
      selenium_driver.should_receive(:send_keys).with([:control, 'a'])
      selenium_element.send_keys([:control, 'a'])
    end
    
    it "should clear its' contents" do
      selenium_driver.should_receive(:clear)
      selenium_element.clear
    end
  end
end