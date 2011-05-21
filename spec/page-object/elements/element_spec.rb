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
  end
end