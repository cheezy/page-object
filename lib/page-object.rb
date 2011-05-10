
require 'page-object/version'
require 'page-object/watir_page_object'
require 'page-object/selenium_page_object'

module PageObject
  def initialize(browser)
    @browser = browser
    include_platform_module
  end

  private

  def include_platform_module
    if @browser.kind_of? Watir::Browser
      self.class.send :include, PageObject::WatirPageObject
    elsif @browser.kind_of? Selenium::WebDriver::Driver
      self.class.send :include, PageObject::SeleniumPageObject
    else
      raise ArgumentError, "expect Watir::Browser or Selenium::WebDriver::Driver"
    end
  end
end
