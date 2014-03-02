require 'spec_helper'
require 'page-object/elements/element'

describe "Element for Watir" do
  let(:watir_driver) { double('watir_driver') }
  let(:watir_element) { ::PageObject::Elements::Element.new(watir_driver, :platform => :watir_webdriver) }

  before(:each) do
    Selenium::WebDriver::Mouse.stub(:new).and_return(watir_driver)
  end

  it "should know when it is visible" do
    watir_driver.stub(:present?).and_return(true)
    watir_driver.stub(:displayed?).and_return(true)
    watir_element.visible?.should == true
  end

  it "should know when it is not visible" do
    watir_driver.stub(:present?).and_return(false)
    watir_driver.stub(:displayed?).and_return(false)
    watir_element.visible?.should == false
  end

  it "should know when it exists" do
    watir_driver.stub(:exists?).and_return(true)
    watir_element.exists?.should == true
  end

  it "should know when it does not exist" do
    watir_driver.stub(:exists?).and_return(false)
    watir_driver.stub(:nil?).and_return(true)
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
    watir_driver.stub(:value).and_return("value")
    watir_driver.stub(:attribute).and_return("value")
    watir_element.value.should == "value"
  end

  it "should know how to retrieve the value of an attribute" do
    watir_driver.stub(:attribute_value).and_return(true)
    watir_driver.stub(:attribute).and_return(true)
    watir_element.attribute("readonly").should be true
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
    watir_driver.stub(:right_click)
    watir_driver.stub(:context_click)
    watir_element.right_click
  end

  it "should be able to block until it is present" do
    watir_driver.stub(:wait_until_present).with(10)
    watir_element.when_present(10)
  end
  
  it "should return the element when it is present" do
    watir_driver.stub(:wait_until_present).with(10)
    element = watir_element.when_present(10)
    element.should === watir_element
  end

  it "should use the overriden wait when set" do
    PageObject.default_element_wait = 20
    watir_driver.stub(:wait_until_present).with(20)
    watir_element.when_present
  end

  it "should be able to block until it is visible" do
    ::Watir::Wait.stub(:until).with(10, "Element was not visible in 10 seconds")
    watir_driver.stub(:displayed?).and_return(true)
    watir_element.when_visible(10)
  end
  
  it "should return the element when it is visible" do
    ::Watir::Wait.stub(:until).with(10, "Element was not visible in 10 seconds")
    watir_driver.stub(:displayed?).and_return(true)
    element = watir_element.when_visible(10)
    element.should === watir_element
  end

  it "should be able to block until it is not visible" do
    ::Watir::Wait.stub(:while).with(10, "Element still visible after 10 seconds")
    watir_driver.stub(:displayed?).and_return(false)
    watir_element.when_not_visible(10)
  end
  
  it "should return the element when it is not visible" do
    ::Watir::Wait.stub(:while).with(10, "Element still visible after 10 seconds")
    watir_driver.stub(:displayed?).and_return(false)
    element = watir_element.when_not_visible(10)
    element.should === watir_element
  end

  it "should be able to block until a user define event fires true" do
    ::Watir::Wait.stub(:until).with(10, "Element blah")
    watir_element.wait_until(10, "Element blah") {true}
  end
  
  it "should send keys to the element" do
    watir_driver.should_receive(:send_keys).with([:control, 'a'])
    watir_element.send_keys([:control, 'a'])
  end
  
  it "should clear its' contents" do
    watir_driver.should_receive(:clear)
    watir_element.clear
  end

  it "should scroll into view" do
    watir_driver.stub(:wd).and_return(watir_driver)
    watir_driver.should_receive(:location_once_scrolled_into_view)
    watir_element.scroll_into_view
  end
end
