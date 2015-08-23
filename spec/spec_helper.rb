# encoding: utf-8
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'simplecov'
require 'coveralls'
SimpleCov.start { add_filter 'spec/' }

require 'rspec'
require 'watir-webdriver'
require 'selenium-webdriver'

require 'page-object'

def mock_watir_browser
  watir_browser = double('watir')
  allow(watir_browser).to receive(:is_a?).with(anything()).and_return(false)
  allow(watir_browser).to receive(:is_a?).with(Watir::Browser).and_return(true)
  watir_browser
end


def mock_selenium_browser
  selenium_browser = double('selenium')
  allow(selenium_browser).to receive(:is_a?).with(anything).and_return(false)
  allow(selenium_browser).to receive(:is_a?).with(Selenium::WebDriver::Driver).and_return(true)
  selenium_browser
end


def mock_adapter(browser, page_object)
  adapter = double('adapter')
  allow(adapter).to receive(:is_for?).with(anything()).and_return false
  allow(adapter).to receive(:is_for?).with(browser).and_return true
  allow(adapter).to receive(:create_page_object).and_return page_object
  allow(adapter).to receive(:root_element_for).and_return browser
  allow(adapter).to receive(:browser_for).and_return browser
  adapter
end

def mock_adapters(adapters)
  allow(PageObject::Platforms).to receive(:get).and_return adapters
end
