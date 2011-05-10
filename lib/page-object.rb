
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
    else
      self.class.send :include, PageObject::SeleniumPageObject
    end
  end
end
