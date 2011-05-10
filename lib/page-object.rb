
require 'page-object/version'
require 'page-object/watir_page_object'

module PageObject
  def initialize(browser)
    @browser = browser
    self.class.send :include, PageObject::WatirPageObject
  end
end
