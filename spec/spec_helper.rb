# encoding: utf-8
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

if ENV['coverage']
  raise "simplecov only works on Ruby 1.9" unless RUBY_VERSION =~ /^1\.9/

  require 'simplecov'
  SimpleCov.start { add_filter "spec/" }
end

require 'rspec'
require 'watir-webdriver'
require 'selenium-webdriver'

require 'page-object'

def mock_watir_browser
  watir_browser = double('watir')
  watir_browser.stub(:is_a?).with(anything()).and_return(false)
  watir_browser.stub(:is_a?).with(Watir::Browser).and_return(true)
  watir_browser
end


def mock_selenium_browser
  selenium_browser = double('selenium')
  selenium_browser.stub(:is_a?).with(Watir::Browser).and_return(false)
  selenium_browser.stub(:is_a?).with(Selenium::WebDriver::Driver).and_return(true)
  selenium_browser
end


def mock_adapter(browser, page_object)
  adapter = double('adapter')
  adapter.stub(:is_for?).with(anything()).and_return false
  adapter.stub(:is_for?).with(browser).and_return true
  adapter.stub(:create_page_object).and_return page_object
  adapter
end

def mock_adapters(adapters)
  PageObject::Platforms.stub(:get).and_return adapters
end
