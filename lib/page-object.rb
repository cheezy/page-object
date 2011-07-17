
require 'page-object/version'
require 'page-object/accessors'

#
# Module that when included adds functionality to a page object.  This module
# will add numerous class and instance methods that you use to define and
# interact with web pages.
#
# If we have a login page with a username and password textfield and a login
# button we might define our page like the one below.  We can then interact with
# the object using the generated methods.
#
# @example Login page example 
#   class LoginPage
#     include PageObject
#
#     text_field(:username, :id => 'user')
#     text_field(:password, :id => 'pass')
#     button(:login, :value => 'Login')
#   end
#
#   ...
#
#   browser = Watir::Browser.new :firefox
#   login_page = LoginPage.new(browser)
#   login_page.username = 'cheezy'
#   login_page.password = 'secret'
#   login_page.login
#
# @see PageObject::Accessors to see what class level methods are added to this module at runtime.
#
module PageObject
  # @return [Watir::Browser or Selenium::WebDriver::Driver] the platform browser passed to the constructor
  attr_reader :browser
  # @return [PageObject::WatirPageObject or PageObject::SeleniumPageObject] the platform page object
  attr_reader :platform

  #
  # Construct a new page object.
  #
  # @param [Watir::Browser or Selenium::WebDriver::Driver] the platform browser to use
  #
  def initialize(browser, visit=false)
    @browser = browser
    include_platform_driver(browser)
    goto if visit && respond_to?(:goto)
  end

  # @private
  def self.included(cls)
    cls.extend PageObject::Accessors
  end
  
  #
  # navigate to the provided url
  #
  # @param [String] the full url to navigate to
  #
  def navigate_to(url)
    platform.navigate_to(url)
  end
  
  #
  # Returns the text of the current page
  #
  def text
    platform.text
  end

  #
  # Returns the html of the current page
  #
  def html
    platform.html
  end

  #
  # Returns the title of the current page
  #
  def title
    platform.title
  end
  
  #
  # Wait until the block returns true or times out
  #
  # Example:
  #   @page.wait_until(5, 'Success not found on page') do
  #     @page.text.include? 'Success'
  #   end
  #
  # @param [Numeric] the amount of time to wait for the block to return true.
  # @param [String] the message to include with the error if we exceed the timeout duration.
  # param block the block to execute.  It should return true when successful.
  #
  def wait_until(timeout = 30, message = nil, &block)
    platform.wait_until(timeout, message, &block)
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
