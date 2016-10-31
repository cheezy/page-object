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
    allow(selenium_browser).to receive(:switch_to).and_return(selenium_browser)
    allow(selenium_browser).to receive(:default_content)
  end

  context "when building identifiers hash" do
    it "should add tag_name when identifying by text for hidden_field" do
      expected_identifier = {:text => 'foo', :tag_name => 'input', :type => 'hidden'}
      expect(PageObject::Elements::HiddenField).to receive(:selenium_identifier_for).with(expected_identifier)
      expect(selenium_browser).to receive(:find_element)
      selenium_page_object.platform.hidden_field_for(:text => 'foo')
    end

    it "should add tag_name when identifying by href for anchor" do
      expected_identifier = {:href => 'foo', :tag_name => 'a'}
      expect(PageObject::Elements::Link).to receive(:selenium_identifier_for).with(expected_identifier)
      expect(selenium_browser).to receive(:find_element)
      selenium_page_object.platform.link_for(:href => 'foo')
    end
    
    it "should add tag_name when identifying by text for div" do
      expected_identifier = {:text => 'foo', :tag_name => 'div'}
      expect(PageObject::Elements::Div).to receive(:selenium_identifier_for).with(expected_identifier)
      expect(selenium_browser).to receive(:find_element)
      selenium_page_object.platform.div_for(:text => 'foo')
    end
  end

  context "when trying to find an element that does not exist" do
    it "should return a surogate selenium object" do
      expect(selenium_browser).to receive(:find_element).and_raise(Selenium::WebDriver::Error::NoSuchElementError)
      page = SeleniumTestPageObject.new(selenium_browser)
      element = page.link_element(:text => 'blah')
      expect(element.element).to be_instance_of PageObject::Platforms::SeleniumWebDriver::SurrogateSeleniumElement
    end

    it "should know it is not exist" do
      expect(selenium_browser).to receive(:find_element).twice.and_raise(Selenium::WebDriver::Error::NoSuchElementError)
      page = SeleniumTestPageObject.new(selenium_browser)
      expect(page.link_element(:text => 'blah').element.exists?).to be false
    end

    it "should know it is not visible" do
      expect(selenium_browser).to receive(:find_element).twice.and_raise(Selenium::WebDriver::Error::NoSuchElementError)
      page = SeleniumTestPageObject.new(selenium_browser)
      expect(page.link_element(:text => 'blah').element).not_to be_visible
    end

    it "should raise an error when actions are requested" do
      expect(selenium_browser).to receive(:find_element).and_raise(Selenium::WebDriver::Error::NoSuchElementError)
      page = SeleniumTestPageObject.new(selenium_browser)
      element = page.link_element(:text => 'blah')
      expect { element.text }.to raise_error Selenium::WebDriver::Error::NoSuchElementError
    end
  end
end
