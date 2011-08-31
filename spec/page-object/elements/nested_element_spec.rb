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
  end
  
  context "in Selenium" do
    it "should find nested links" do
      selenium_driver.should_receive(:find_element).with(:id, 'blah').and_return(selenium_driver)
      selenium_element.link_element(:id => 'blah')
    end
  end
end
