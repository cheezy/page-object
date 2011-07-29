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

module PageObject
  module PersistantBrowser
    @@browser = false
    def self.get_browser 
      if !@@browser 
         @@browser =  Watir::Browser.new :firefox if ENV['DRIVER'] == 'WATIR' 
         @@browser =  Selenium::WebDriver.for :firefox if ENV['DRIVER'] == 'SELENIUM'
      end
      return @@browser
    end
    def self.quit
      @@browser.quit
    end
  end  
end
