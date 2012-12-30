
module PageObject
  module PersistantBrowser
    @@browser = false
    def self.get_browser
      if !@@browser
        target = ENV['BROWSER']
        target = 'firefox_local' unless target

        require File.dirname(__FILE__) + "/targets/#{target}"
        extend Target

        @@browser =  watir_browser if ENV['DRIVER'] == 'WATIR'
        @@browser =  selenium_browser if ENV['DRIVER'] == 'SELENIUM'
      end
      @@browser
    end
    def self.quit
      @@browser.quit
    end
  end
end
