$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rspec/expectations'
require 'watir-webdriver'
require 'selenium-webdriver'

require 'page-object'

Before do
  @browser = Watir::Browser.new :firefox if ENV['DRIVER'] == 'WATIR'
  @browser = Selenium::WebDriver.for :firefox if ENV['DRIVER'] == 'SELENIUM'
end

After do |s|
  @browser.quit
end


