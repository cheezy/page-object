require 'selenium/webdriver/remote/http/persistent'

module PageObject
  module PersistentBrowser
    @@browser = false
    def self.get_browser
      if !@@browser
        target = ENV['BROWSER'] || 'local_chrome'

        if is_remote?(target)
          require File.dirname(__FILE__) + "/targets/#{target}"
          extend Target
        end

        @@browser =  ENV['DRIVER'] == 'SELENIUM' ? selenium_browser(target) : watir_browser(target)
      end
      @@browser
    end
    
    def self.quit
      @@browser.quit
    end

    private

    def self.is_remote?(target)
      not target.include? 'local'
    end

    def self.watir_browser(target)
      if is_remote?(target)
        Watir::Browser.new(:remote,
                           :url => url,
                           :desired_capabilities => desired_capabilities)
      else
        browser = target.gsub('local_', '').to_sym
        Watir::Browser.new browser
      end
    end

    def self.selenium_browser(target)
      if is_remote?(target)
        Selenium::WebDriver.for(:remote,
                                :url => url,
                                :desired_capabilities => desired_capabilities)
      else
        browser = target.gsub('local_', '').to_sym
        Selenium::WebDriver.for browser
      end
    end

    def self.capabilities(browser, version, platform, name)
      caps = Selenium::WebDriver::Remote::Capabilities.send browser
      caps.version = version
      caps.platform = platform
      caps[:name] = name
      caps
    end

    def self.url
      "http://pageobject:18002ee8-963b-472e-9425-2baf0a2b6d95@ondemand.saucelabs.com:80/wd/hub"
    end
  end
end
