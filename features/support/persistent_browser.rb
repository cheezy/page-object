
module PageObject
  module PersistantBrowser
    @@browser = false
    def self.get_browser
      if !@@browser
         @@browser =  Watir::Browser.new :firefox if ENV['DRIVER'] == 'WATIR'
         @@browser =  Selenium::WebDriver.for :firefox if ENV['DRIVER'] == 'SELENIUM'
      end
      @@browser
    end
    def self.quit
      @@browser.quit
    end
  end
end
