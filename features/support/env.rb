require 'rspec/expectations'
require 'watir-webdriver'
require 'selenium-webdriver'

require 'page-object'

Before('@watir') do
  @browser = Watir::Browser.new :firefox
end

After('@watir') do
  @browser.close
end

Before('@selenium') do
  @browser = Selenium::WebDriver.for :firefox
end

After('@selenium') do
  @browser.close
end

