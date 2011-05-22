
require 'page-object/version'
require 'page-object/accessors'

# Module that when included adds core functionality to a page object.
module PageObject
  attr_reader :platform

  # Construct a new page object.  The browser parameter must be either a
  # Watir::Browser or Selenium::WebDriver::Driver.
  def initialize(browser)
    include_platform_driver(browser)
  end

  def self.included(cls)
    cls.extend PageObject::Accessors
  end
  
  # navigate to the provided url
  def navigate_to(url)
    platform.navigate_to(url)
  end
  
  # Returns the text of the current page
  def text
    platform.text
  end

  # Returns the html of the current page
  def html
    platform.html
  end

  # Returns the title of the current page
  def title
    platform.title
  end

  private

  def include_platform_driver(browser)
    if browser.is_a? Watir::Browser
      require 'page-object/watir_page_object'
      @platform = PageObject::WatirPageObject.new(browser)
    elsif browser.is_a? Selenium::WebDriver::Driver
      require 'page-object/selenium_page_object'
      @platform = PageObject::SeleniumPageObject.new(browser)
    else
      raise ArgumentError, "expect Watir::Browser or Selenium::WebDriver::Driver"
    end
  end
end
