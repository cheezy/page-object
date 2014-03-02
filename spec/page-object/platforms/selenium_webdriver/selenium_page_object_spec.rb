require 'spec_helper'
require 'page-object/platforms/selenium_webdriver/page_object'
require 'page-object/elements'

class SeleniumTestPageObject
  include PageObject
end

describe PageObject::Platforms::SeleniumWebDriver::PageObject do
  let(:selenium_browser) { mock_selenium_browser }
  let(:selenium_page_object) { SeleniumTestPageObject.new(selenium_browser) }
  
  before(:each) do
    selenium_browser.stub(:switch_to).and_return(selenium_browser)
    selenium_browser.stub(:default_content)
  end

  context "when building identifiers hash" do
    it "should add tag_name when identifying by text for hidden_field" do
      expected_identifier = {:text => 'foo', :tag_name => 'input', :type => 'hidden'}
      PageObject::Elements::HiddenField.should_receive(:selenium_identifier_for).with(expected_identifier)
      selenium_browser.should_receive(:find_element)
      selenium_page_object.platform.hidden_field_for(:text => 'foo')
    end

    it "should add tag_name when identifying by href for anchor" do
      expected_identifier = {:href => 'foo', :tag_name => 'a'}
      PageObject::Elements::Link.should_receive(:selenium_identifier_for).with(expected_identifier)
      selenium_browser.should_receive(:find_element)
      selenium_page_object.platform.link_for(:href => 'foo')
    end
    
    it "should add tag_name when identifying by text for div" do
      expected_identifier = {:text => 'foo', :tag_name => 'div'}
      PageObject::Elements::Div.should_receive(:selenium_identifier_for).with(expected_identifier)
      selenium_browser.should_receive(:find_element)
      selenium_page_object.platform.div_for(:text => 'foo')
    end
  end

  context "when trying to find an element that does not exist" do
    it "should return a surogate selenium object" do
      selenium_browser.should_receive(:find_element).and_raise(Selenium::WebDriver::Error::NoSuchElementError)
      page = SeleniumTestPageObject.new(selenium_browser)
      element = page.link_element(:text => 'blah')
      element.element.should be_instance_of PageObject::Platforms::SeleniumWebDriver::SurrogateSeleniumElement
    end

    it "should know it is not exist" do
      selenium_browser.should_receive(:find_element).twice.and_raise(Selenium::WebDriver::Error::NoSuchElementError)
      page = SeleniumTestPageObject.new(selenium_browser)
      page.link_element(:text => 'blah').element.exists?.should be false
    end

    it "should know it is not visible" do
      selenium_browser.should_receive(:find_element).twice.and_raise(Selenium::WebDriver::Error::NoSuchElementError)
      page = SeleniumTestPageObject.new(selenium_browser)
      page.link_element(:text => 'blah').element.should_not be_visible
    end

    it "should raise an error when actions are requested" do
      selenium_browser.should_receive(:find_element).and_raise(Selenium::WebDriver::Error::NoSuchElementError)
      page = SeleniumTestPageObject.new(selenium_browser)
      element = page.link_element(:text => 'blah')
      expect { element.text }.to raise_error
    end
  end
end
