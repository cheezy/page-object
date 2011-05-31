require 'spec_helper'
require 'page-object/elements'


describe PageObject::Elements::Element do
  let(:watir_driver) { double('watir') }
  let(:selenium_driver) { double('selenium') }
  let(:watir_element) { PageObject::Elements::Element.new(watir_driver, :platform => :watir) }
  let(:selenium_element) { PageObject::Elements::Element.new(selenium_driver, :platform => :selenium) }

  context "on a Watir page-object" do
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
  end
  
  context "on a Selenium page-object" do
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
  end
end