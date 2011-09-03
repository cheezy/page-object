require 'spec_helper'
require 'page-object/elements'


describe "Element with nested elements" do
  let(:watir_driver) { double('watir') }
  let(:watir_element) { PageObject::Elements::Element.new(watir_driver, :platform => :watir_webdriver) }
  let(:selenium_driver) { double('selenium') }
  let(:selenium_element) { PageObject::Elements::Element.new(selenium_driver, :platform => :selenium_webdriver) }


  context "in Watir" do
    it "should find nested links" do
      watir_driver.should_receive(:link).with(:id => 'blah').and_return(watir_driver)
      watir_element.link_element(:id => 'blah')
    end

    it "should find nested buttons" do
      watir_driver.should_receive(:button).with(:id => 'blah').and_return(watir_driver)
      watir_element.button_element(:id => 'blah')
    end
    
    it "should find nested text fields" do
      watir_driver.should_receive(:text_field).with(:id => 'blah').and_return(watir_driver)
      watir_element.text_field_element(:id => 'blah')
    end

    it "should find nested hidden fields" do
      watir_driver.should_receive(:hidden).and_return(watir_driver)
      watir_element.hidden_field_element
    end

    it "should find nested text areas" do
      watir_driver.should_receive(:textarea).and_return(watir_driver)
      watir_element.text_area_element
    end

    it "should find a nested select list" do
      watir_driver.should_receive(:select_list).and_return(watir_driver)
      watir_element.select_list_element
    end
  end
  
  context "in Selenium" do
    it "should find nested links" do
      selenium_driver.should_receive(:find_element).with(:id, 'blah').and_return(selenium_driver)
      selenium_element.link_element(:id => 'blah')
    end

    it "should find nested buttons" do
      selenium_driver.should_receive(:find_element).with(:id, 'blah').and_return(selenium_driver)
      selenium_element.button_element(:id => 'blah')
    end
    
    it "should find nested text fields" do
      selenium_driver.should_receive(:find_element).with(:id, 'blah').and_return(selenium_driver)
      selenium_element.text_field_element(:id => 'blah')
    end
    
    it "should find nested hidden fields" do
      selenium_driver.should_receive(:find_element).and_return(selenium_driver)
      selenium_element.hidden_field_element
    end
    
    it "should find nested text areas" do
      selenium_driver.should_receive(:find_element).and_return(selenium_driver)
      selenium_element.text_area_element
    end
    
    it "should find a nested select list" do
      selenium_driver.should_receive(:find_element).and_return(selenium_driver)
      selenium_element.select_list_element
    end

  end
end
