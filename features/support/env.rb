$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rspec/expectations'
require 'watir-webdriver'
require 'selenium-webdriver'

require 'page-object'



Before do
  @browser = PageObject::PersistantBrowser.get_browser
end
at_exit do
  PageObject::PersistantBrowser.quit
end

